package com.company.vehiclewash.washer.profile;

import com.company.vehiclewash.auth.entity.User;
import com.company.vehiclewash.auth.repository.UserRepository;
import com.company.vehiclewash.security.SecurityUtils;
import com.company.vehiclewash.washer.entity.Washer;
import com.company.vehiclewash.washer.repository.WasherRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.HashMap;
import java.util.Map;

@Service
public class WasherProfileService {

    private final WasherRepository washerRepository;
    private final UserRepository userRepository;

    public WasherProfileService(WasherRepository washerRepository, UserRepository userRepository) {
        this.washerRepository = washerRepository;
        this.userRepository = userRepository;
    }

    @Transactional(readOnly = true)
    public WasherProfileResponse getProfile() {
        Washer washer = getAuthenticatedWasher();
        return mapToResponse(washer);
    }

    @Transactional
    public WasherProfileResponse updateProfile(UpdateWasherProfileRequest request) {
        Washer washer = getAuthenticatedWasher();
        washer.setFullName(request.getFullName());
        Washer updatedWasher = washerRepository.save(washer);
        return mapToResponse(updatedWasher);
    }

    @Transactional
    public WasherProfileResponse updateHomeBase(UpdateHomeBaseRequest request) {
        Washer washer = getAuthenticatedWasher();
        washer.setHomeAddress(request.getAddress());
        washer.setHomeLatitude(request.getLatitude());
        washer.setHomeLongitude(request.getLongitude());
        Washer updatedWasher = washerRepository.save(washer);
        return mapToResponse(updatedWasher);
    }

    private Washer getAuthenticatedWasher() {
        User user = userRepository.findById(SecurityUtils.getCurrentWasherId())
                .orElseThrow(() -> new RuntimeException("User not found"));
        return washerRepository.findByMobileNumber(user.getMobileNumber())
                .orElseThrow(() -> new RuntimeException("Washer not found"));
    }

    private WasherProfileResponse mapToResponse(Washer washer) {
        WasherProfileResponse response = new WasherProfileResponse();
        response.setId(washer.getId());
        response.setFullName(washer.getFullName());
        response.setMobileNumber(washer.getMobileNumber());
        response.setVerificationStatus(washer.getVerificationStatus());
        response.setAverageRating(washer.getAverageRating());
        response.setTrustScore(washer.getTrustScore());
        response.setTotalCompletedJobs(washer.getTotalCompletedJobs());
        
        Map<String, Object> homeBase = new HashMap<>();
        homeBase.put("address", washer.getHomeAddress());
        homeBase.put("latitude", washer.getHomeLatitude());
        homeBase.put("longitude", washer.getHomeLongitude());
        response.setHomeBase(homeBase);
        
        return response;
    }
}
