package com.company.vehiclewash.washer.profile;

import com.company.vehiclewash.common.response.ApiResponse;
import com.company.vehiclewash.security.SecurityUtils;
import com.company.vehiclewash.washer.entity.Washer;
import com.company.vehiclewash.washer.repository.WasherRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/washers")
public class WasherProfileController {

    private final WasherRepository washerRepository;
    private final com.company.vehiclewash.auth.repository.UserRepository userRepository;

    public WasherProfileController(WasherRepository washerRepository, com.company.vehiclewash.auth.repository.UserRepository userRepository) {
        this.washerRepository = washerRepository;
        this.userRepository = userRepository;
    }

    @GetMapping("/me")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getProfile() {
        com.company.vehiclewash.auth.entity.User user = userRepository.findById(SecurityUtils.getCurrentWasherId())
                .orElseThrow(() -> new RuntimeException("User not found"));
        Washer washer = washerRepository.findByMobileNumber(user.getMobileNumber())
                .orElseThrow(() -> new RuntimeException("Washer not found"));
                
        Map<String, Object> data = new HashMap<>();
        data.put("id", washer.getId());
        data.put("fullName", washer.getFullName());
        data.put("mobileNumber", washer.getMobileNumber());
        data.put("verificationStatus", washer.getVerificationStatus());
        data.put("averageRating", washer.getAverageRating());
        data.put("trustScore", washer.getTrustScore());
        data.put("totalCompletedJobs", washer.getTotalCompletedJobs());
        
        Map<String, Object> homeBase = new HashMap<>();
        homeBase.put("address", washer.getHomeAddress());
        homeBase.put("latitude", washer.getHomeLatitude());
        homeBase.put("longitude", washer.getHomeLongitude());
        data.put("homeBase", homeBase);

        return ResponseEntity.ok(ApiResponse.success(data));
    }
}
