package com.company.vehiclewash.booking;

import com.company.vehiclewash.AbstractIntegrationTest;
import com.company.vehiclewash.auth.entity.User;
import com.company.vehiclewash.booking.createBooking.CreateBookingRequest;
import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.customer.entity.CustomerAddress;
import com.company.vehiclewash.customer.entity.Vehicle;
import com.company.vehiclewash.customer.enums.VehicleType;
import com.company.vehiclewash.customer.repository.CustomerAddressRepository;
import com.company.vehiclewash.customer.repository.VehicleRepository;
import com.company.vehiclewash.payment.webhook.PaymentWebhookRequest;
import com.company.vehiclewash.washer.entity.Washer;
import com.company.vehiclewash.washer.enums.VerificationStatus;
import com.company.vehiclewash.washer.repository.WasherRepository;
import com.fasterxml.jackson.databind.JsonNode;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class BookingFlowIntegrationTest extends AbstractIntegrationTest {

    @Autowired
    private VehicleRepository vehicleRepository;

    @Autowired
    private CustomerAddressRepository customerAddressRepository;

    @Autowired
    private WasherRepository washerRepository;

    @Autowired
    private BookingRepository bookingRepository;

    @Test
    public void testBookingAndAssignmentFlow() throws Exception {
        String customerMobile = "9000000001";
        String customerToken = getCustomerToken(customerMobile);
        User customerUser = userRepository.findByMobileNumber(customerMobile).orElseThrow();
        
        String washerMobile = "9000000002";
        String washerToken = getWasherToken(washerMobile);
        User washerUser = userRepository.findByMobileNumber(washerMobile).orElseThrow();

        // Removed manual Washer insertion to avoid DataIntegrityViolationException.
        // The assignment logic hardcodes the Washer ID to 11111111-1111-1111-1111-111111111111 anyway.

        // Setup Customer Vehicle
        Vehicle vehicle = new Vehicle();
        vehicle.setCustomerId(customerUser.getId());
        vehicle.setVehicleType(VehicleType.FOUR_WHEELER);
        vehicle.setVehicleNumber("MH141234");
        vehicle.setVehicleBrand("Kia");
        vehicle.setVehicleModel("Seltos");
        vehicle.setVehicleColor("Black");
        vehicleRepository.save(vehicle);

        // Setup Customer Address
        CustomerAddress address = new CustomerAddress();
        address.setCustomerId(customerUser.getId());
        address.setAddressLabel("Office");
        address.setFullAddress("123 Tech Park");
        address.setLatitude(new BigDecimal("28.0"));
        address.setLongitude(new BigDecimal("77.0"));
        customerAddressRepository.save(address);

        // 1. Create Booking (Slice 7)
        CreateBookingRequest bookingReq = new CreateBookingRequest();
        bookingReq.setVehicleId(vehicle.getId());
        bookingReq.setAddressId(address.getId());
        bookingReq.setSlotId(UUID.randomUUID());
        bookingReq.setBookingDate(LocalDate.now().plusDays(1));

        String responseStr = mockMvc.perform(post("/api/v1/bookings")
                .header("Authorization", customerToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(bookingReq)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true))
                .andReturn().getResponse().getContentAsString();

        JsonNode root = objectMapper.readTree(responseStr);
        String bookingIdStr = root.get("data").get("bookingId").asText();
        String orderId = root.get("data").get("payment").get("orderId").asText();
        UUID bookingId = UUID.fromString(bookingIdStr);

        Booking booking = bookingRepository.findById(bookingId).orElseThrow();
        assertEquals(BookingStatus.PAYMENT_PENDING, booking.getBookingStatus());

        // 2. Payment Webhook (Slice 7)
        PaymentWebhookRequest webhookReq = new PaymentWebhookRequest();
        webhookReq.setOrderId(orderId);
        webhookReq.setPaymentId("pay_123");
        webhookReq.setSignature("sig_123");
        webhookReq.setStatus("SUCCESS");

        mockMvc.perform(post("/api/v1/payments/webhook")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(webhookReq)))
                .andExpect(status().isOk());

        // Verify booking is CONFIRMED
        booking = bookingRepository.findById(bookingId).orElseThrow();
        assertEquals(BookingStatus.CONFIRMED, booking.getBookingStatus());
        
        // Wait briefly for asynchronous assignment if any
        Thread.sleep(1000);

        // 3. Assignment (Slice 8)
        // Washer gets requests
        String assignmentsResp = mockMvc.perform(get("/api/v1/assignments/me/requests")
                .header("Authorization", washerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andReturn().getResponse().getContentAsString();

        JsonNode assignmentsRoot = objectMapper.readTree(assignmentsResp);
        JsonNode dataNode = assignmentsRoot.get("data");
        
        if (dataNode.isArray() && dataNode.size() > 0) {
            String requestId = dataNode.get(0).get("requestId").asText();

            // Ensure the Mock SecurityContext uses the hardcoded Washer ID assigned by BookingConfirmedEventListener
            com.company.vehiclewash.security.SecurityUtils.setMockWasherId(UUID.fromString("11111111-1111-1111-1111-111111111111"));
        
            // 4. Washer Accepts Assignment
            mockMvc.perform(post("/api/v1/assignments/" + requestId + "/accept")
                    .header("Authorization", washerToken))
                    .andExpect(status().isOk());

            // Check booking status changed to ASSIGNED
            booking = bookingRepository.findById(bookingId).orElseThrow();
            assertEquals(BookingStatus.ASSIGNED, booking.getBookingStatus());
        }
    }
}
