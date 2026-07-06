package com.company.vehiclewash.booking.execution;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/bookings")
public class ExecutionController {

    private final ExecutionService executionService;

    public ExecutionController(ExecutionService executionService) {
        this.executionService = executionService;
    }

    @PutMapping("/{bookingId}/status")
    public ResponseEntity<ApiResponse<Void>> updateStatus(
            @PathVariable UUID bookingId, 
            @Valid @RequestBody UpdateBookingStatusRequest request) {
        executionService.updateBookingStatus(bookingId, request);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
