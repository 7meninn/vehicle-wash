package com.company.vehiclewash.washer.profile;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/v1/washers")
public class WasherProfileController {

    private final WasherProfileService washerProfileService;

    public WasherProfileController(WasherProfileService washerProfileService) {
        this.washerProfileService = washerProfileService;
    }

    @GetMapping("/me")
    @PreAuthorize("hasRole('WASHER')")
    public ResponseEntity<ApiResponse<WasherProfileResponse>> getProfile() {
        return ResponseEntity.ok(ApiResponse.success(washerProfileService.getProfile()));
    }

    @PutMapping("/me")
    @PreAuthorize("hasRole('WASHER')")
    public ResponseEntity<ApiResponse<WasherProfileResponse>> updateProfile(@Valid @RequestBody UpdateWasherProfileRequest request) {
        return ResponseEntity.ok(ApiResponse.success(washerProfileService.updateProfile(request)));
    }

    @PutMapping("/me/home-base")
    @PreAuthorize("hasRole('WASHER')")
    public ResponseEntity<ApiResponse<WasherProfileResponse>> updateHomeBase(@Valid @RequestBody UpdateHomeBaseRequest request) {
        return ResponseEntity.ok(ApiResponse.success(washerProfileService.updateHomeBase(request)));
    }
}
