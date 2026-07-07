package com.company.vehiclewash.customer.profile;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/customers")
public class CustomerProfileController {
    
    private final CustomerProfileService customerProfileService;
    
    public CustomerProfileController(CustomerProfileService customerProfileService) {
        this.customerProfileService = customerProfileService;
    }
    
    @GetMapping("/me")
    @PreAuthorize("hasRole('CUSTOMER')")
    public ResponseEntity<ApiResponse<CustomerProfileResponse>> getProfile() {
        return ResponseEntity.ok(ApiResponse.success(customerProfileService.getProfile()));
    }
    
    @PutMapping("/me")
    @PreAuthorize("hasRole('CUSTOMER')")
    public ResponseEntity<ApiResponse<CustomerProfileResponse>> updateProfile(@Valid @RequestBody UpdateCustomerProfileRequest request) {
        return ResponseEntity.ok(ApiResponse.success(customerProfileService.updateProfile(request)));
    }
}
