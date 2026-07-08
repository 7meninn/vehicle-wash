package com.company.vehiclewash.dispute;

import com.company.vehiclewash.AbstractIntegrationTest;
import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.dispute.createDispute.CreateDisputeRequest;
import com.company.vehiclewash.dispute.enums.DisputeStatus;
import com.company.vehiclewash.dispute.enums.DisputeType;
import com.company.vehiclewash.dispute.repository.DisputeRepository;
import com.company.vehiclewash.dispute.entity.Dispute;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

public class DisputeIntegrationTest extends AbstractIntegrationTest {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private DisputeRepository disputeRepository;

    @Test
    public void testDisputeFlow() throws Exception {
        String token = getCustomerToken("9998887776");

        // Create a completed booking
        Booking booking = new Booking();
        booking.setBookingStatus(BookingStatus.COMPLETED);
        booking.setCustomerId(UUID.randomUUID());
        booking.setHasDispute(false);
        booking = bookingRepository.save(booking);

        // 1. Create a dispute
        CreateDisputeRequest createReq = new CreateDisputeRequest();
        createReq.setType(DisputeType.BAD_WASH);
        createReq.setDescription("Car is still dirty.");

        mockMvc.perform(post("/bookings/" + booking.getId() + "/dispute")
                .header("Authorization", token)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(createReq)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        List<Dispute> disputes = disputeRepository.findAll();
        assertEquals(1, disputes.size());
        Dispute createdDispute = disputes.get(0);
        assertEquals(DisputeStatus.OPEN, createdDispute.getDisputeStatus());

        // 2. Upload Evidence
        MockMultipartFile file = new MockMultipartFile("file", "evidence.png", "image/png", "dummy-image-content".getBytes());

        mockMvc.perform(multipart("/disputes/" + createdDispute.getId() + "/media")
                .file(file)
                .header("Authorization", token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        // 3. Get Dispute
        mockMvc.perform(get("/disputes/" + createdDispute.getId())
                .header("Authorization", token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.id").value(createdDispute.getId().toString()));

        // 4. Resolve Dispute (By Admin)
        String adminToken = getAdminToken("1112223334");
        com.company.vehiclewash.dispute.resolveDispute.ResolveDisputeRequest resolveReq = new com.company.vehiclewash.dispute.resolveDispute.ResolveDisputeRequest();
        resolveReq.setResolutionType(com.company.vehiclewash.dispute.enums.ResolutionType.REFUND);
        resolveReq.setRefundPercentage(new java.math.BigDecimal("100.00"));
        resolveReq.setPayoutPercentage(new java.math.BigDecimal("0.00"));
        resolveReq.setAdminNotes("Resolved in favor of customer");

        mockMvc.perform(post("/admin/disputes/" + createdDispute.getId() + "/resolve")
                .header("Authorization", adminToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(resolveReq)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        Dispute resolvedDispute = disputeRepository.findById(createdDispute.getId()).get();
        assertEquals(DisputeStatus.RESOLVED, resolvedDispute.getDisputeStatus());
    }
}
