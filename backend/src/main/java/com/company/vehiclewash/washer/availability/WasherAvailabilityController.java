package com.company.vehiclewash.washer.availability;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/v1/washers")
public class WasherAvailabilityController {

    private final WasherAvailabilityService availabilityService;

    public WasherAvailabilityController(WasherAvailabilityService availabilityService) {
        this.availabilityService = availabilityService;
    }

    @GetMapping("/me/availability")
    public ResponseEntity<ApiResponse<List<WasherAvailabilityResponse>>> getAvailability(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate) {
        
        List<WasherAvailabilityResponse> response = availabilityService.getAvailability(fromDate, toDate);
        return ResponseEntity.ok(ApiResponse.success(response));
    }

    // Mapping to POST as explicitly requested, though standard REST might use PUT
    @PostMapping("/me/availability")
    public ResponseEntity<ApiResponse<Void>> updateAvailability(@Valid @RequestBody UpdateAvailabilityRequest request) {
        availabilityService.updateAvailability(request);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
