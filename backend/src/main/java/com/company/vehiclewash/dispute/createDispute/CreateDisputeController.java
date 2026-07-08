package com.company.vehiclewash.dispute.createDispute;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/bookings/{bookingId}/dispute")
@RequiredArgsConstructor
public class CreateDisputeController {

    private final CreateDisputeService createDisputeService;

    @PostMapping
    public ApiResponse<Void> createDispute(
            @PathVariable UUID bookingId,
            @Valid @RequestBody CreateDisputeRequest request) {
        
        createDisputeService.createDispute(bookingId, request);
        return ApiResponse.success(null);
    }
}
