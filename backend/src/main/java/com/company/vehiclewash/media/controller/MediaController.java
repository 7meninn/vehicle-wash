package com.company.vehiclewash.media.controller;

import com.company.vehiclewash.common.response.ApiResponse;
import com.company.vehiclewash.media.dto.MediaUploadResponse;
import com.company.vehiclewash.media.service.MediaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/bookings")
public class MediaController {

    private final MediaService mediaService;

    public MediaController(MediaService mediaService) {
        this.mediaService = mediaService;
    }

    @PostMapping(value = "/{bookingId}/media", consumes = "multipart/form-data")
    public ResponseEntity<ApiResponse<MediaUploadResponse>> uploadMedia(
            @PathVariable UUID bookingId,
            @RequestParam("mediaType") String mediaType,
            @RequestParam("file") MultipartFile file) {
        
        MediaUploadResponse response = mediaService.uploadBookingMedia(bookingId, mediaType, file);
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
