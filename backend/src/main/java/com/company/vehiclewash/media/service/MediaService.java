package com.company.vehiclewash.media.service;

import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.media.dto.MediaUploadResponse;
import com.company.vehiclewash.media.entity.Media;
import com.company.vehiclewash.media.enums.MediaType;
import com.company.vehiclewash.media.repository.MediaRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Service
public class MediaService {

    private final MediaRepository mediaRepository;
    private final BookingRepository bookingRepository;

    public MediaService(MediaRepository mediaRepository, BookingRepository bookingRepository) {
        this.mediaRepository = mediaRepository;
        this.bookingRepository = bookingRepository;
    }

    @Transactional
    public MediaUploadResponse uploadBookingMedia(UUID bookingId, String mediaTypeStr, MultipartFile file) {
        UUID washerId = SecurityUtils.getCurrentWasherId();

        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        if (!washerId.equals(booking.getAssignedWasherId())) {
            throw new RuntimeException("Unauthorized: Not assigned to this booking");
        }

        MediaType mediaType;
        try {
            mediaType = MediaType.valueOf(mediaTypeStr.toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid media type");
        }

        // Mocking S3 Upload - Generate a fake storage key
        String originalFilename = file.getOriginalFilename();
        String storageKey = "bookings/" + bookingId + "/" + mediaType.name() + "_" + System.currentTimeMillis() + "_" + originalFilename;

        Media media = new Media();
        media.setBookingId(bookingId);
        media.setUploadedBy(washerId);
        media.setMediaType(mediaType);
        media.setStorageKey(storageKey);

        media = mediaRepository.save(media);

        MediaUploadResponse response = new MediaUploadResponse();
        response.setMediaId(media.getId());
        response.setStorageKey(storageKey);

        return response;
    }
}
