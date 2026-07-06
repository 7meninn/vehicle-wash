package com.company.vehiclewash.media;

import com.company.vehiclewash.AbstractIntegrationTest;
import com.company.vehiclewash.auth.entity.User;
import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.washer.entity.Washer;
import com.company.vehiclewash.washer.repository.WasherRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;

import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.multipart;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class MediaIntegrationTest extends AbstractIntegrationTest {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private WasherRepository washerRepository;

    @Test
    public void testMediaUploadConstraintsAndLinkage() throws Exception {
        String washerMobile = "9000000003";
        String token = getWasherToken(washerMobile);
        User washerUser = userRepository.findByMobileNumber(washerMobile).orElseThrow();

        // Washer is not actually needed by the MediaService, only the User ID is.

        // Setup Booking
        Booking booking = new Booking();
        booking.setCustomerId(UUID.randomUUID());
        booking.setVehicleId(UUID.randomUUID());
        booking.setAddressId(UUID.randomUUID());
        booking.setSlotId(UUID.randomUUID());
        booking.setAssignedWasherId(washerUser.getId());
        booking = bookingRepository.save(booking);

        // Test File Upload
        MockMultipartFile file = new MockMultipartFile(
                "file",
                "before_wash.jpg",
                MediaType.IMAGE_JPEG_VALUE,
                "dummy image content".getBytes()
        );

        mockMvc.perform(multipart("/api/v1/bookings/" + booking.getId() + "/media")
                .file(file)
                .param("mediaType", "BEFORE_PHOTO")
                .header("Authorization", token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.mediaId").exists())
                .andExpect(jsonPath("$.data.storageKey").exists());

        // Test Unassigned Booking (Unauthorized)
        Booking otherBooking = new Booking();
        otherBooking.setCustomerId(UUID.randomUUID());
        otherBooking.setVehicleId(UUID.randomUUID());
        otherBooking.setAddressId(UUID.randomUUID());
        otherBooking.setSlotId(UUID.randomUUID());
        otherBooking.setAssignedWasherId(UUID.randomUUID()); // Different Washer
        otherBooking = bookingRepository.save(otherBooking);

        mockMvc.perform(multipart("/api/v1/bookings/" + otherBooking.getId() + "/media")
                .file(file)
                .param("mediaType", "BEFORE_PHOTO")
                .header("Authorization", token))
                .andExpect(status().isForbidden());
    }
}
