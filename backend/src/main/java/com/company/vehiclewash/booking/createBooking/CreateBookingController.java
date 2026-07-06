package com.company.vehiclewash.booking.createBooking;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/bookings")
public class CreateBookingController {

    private final CreateBookingService createBookingService;

    public CreateBookingController(CreateBookingService createBookingService) {
        this.createBookingService = createBookingService;
    }

    @PostMapping
    public ResponseEntity<ApiResponse<CreateBookingResponse>> createBooking(@Valid @RequestBody CreateBookingRequest request) {
        CreateBookingResponse response = createBookingService.createBooking(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(response));
    }
}
