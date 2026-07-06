package com.company.vehiclewash.booking.createBooking;

import com.company.vehiclewash.booking.calculateprice.CalculatePriceRequest;
import com.company.vehiclewash.booking.calculateprice.CalculatePriceResponse;
import com.company.vehiclewash.booking.calculateprice.CalculatePriceService;
import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.payment.entity.Payment;
import com.company.vehiclewash.payment.enums.PaymentGateway;
import com.company.vehiclewash.payment.enums.PaymentStatus;
import com.company.vehiclewash.payment.repository.PaymentRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class CreateBookingService {

    private final BookingRepository bookingRepository;
    private final PaymentRepository paymentRepository;
    private final CalculatePriceService calculatePriceService;

    public CreateBookingService(
            BookingRepository bookingRepository,
            PaymentRepository paymentRepository,
            CalculatePriceService calculatePriceService) {
        this.bookingRepository = bookingRepository;
        this.paymentRepository = paymentRepository;
        this.calculatePriceService = calculatePriceService;
    }

    @Transactional
    public CreateBookingResponse createBooking(CreateBookingRequest request) {
        UUID customerId = SecurityUtils.getCurrentUserId();

        // 1. Calculate Price
        CalculatePriceRequest priceRequest = new CalculatePriceRequest();
        priceRequest.setVehicleId(request.getVehicleId());
        priceRequest.setAddressId(request.getAddressId());
        CalculatePriceResponse priceResponse = calculatePriceService.calculatePrice(priceRequest);

        // 2. Create Booking
        Booking booking = new Booking();
        booking.setCustomerId(customerId);
        booking.setVehicleId(request.getVehicleId());
        booking.setAddressId(request.getAddressId());
        booking.setSlotId(request.getSlotId());
        booking.setBookingDate(request.getBookingDate());
        booking.setBookingStatus(BookingStatus.PAYMENT_PENDING);
        booking.setPaymentStatus(PaymentStatus.PENDING);
        
        booking = bookingRepository.save(booking);

        // 3. Create Payment (Mock Payment Order)
        Payment payment = new Payment();
        payment.setBookingId(booking.getId());
        payment.setCustomerId(customerId);
        payment.setPaymentGateway(PaymentGateway.RAZORPAY);
        payment.setGatewayOrderId("order_" + System.currentTimeMillis()); // Mock Order ID
        payment.setPaymentStatus(PaymentStatus.PENDING);
        payment.setAmount(priceResponse.getTotalPrice());
        payment.setCurrency("INR");

        payment = paymentRepository.save(payment);

        // 4. Build Response
        CreateBookingResponse response = new CreateBookingResponse();
        response.setBookingId(booking.getId());
        response.setBookingNumber(booking.getBookingNumber());

        CreateBookingResponse.PaymentDetails paymentDetails = new CreateBookingResponse.PaymentDetails();
        paymentDetails.setGateway(payment.getPaymentGateway().name());
        paymentDetails.setOrderId(payment.getGatewayOrderId());
        paymentDetails.setAmount(payment.getAmount());
        
        response.setPayment(paymentDetails);

        return response;
    }
}
