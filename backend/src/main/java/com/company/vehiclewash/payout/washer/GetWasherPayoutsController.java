package com.company.vehiclewash.payout.washer;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/washers/me/payouts")
public class GetWasherPayoutsController {

    private final GetWasherPayoutsService getWasherPayoutsService;

    public GetWasherPayoutsController(GetWasherPayoutsService getWasherPayoutsService) {
        this.getWasherPayoutsService = getWasherPayoutsService;
    }

    @GetMapping
    @PreAuthorize("hasRole('WASHER')")
    public ApiResponse<List<WasherPayoutResponse>> getMyPayouts(Authentication authentication) {
        // authentication.getName() should return user ID string
        UUID washerId = UUID.fromString(authentication.getName());
        return ApiResponse.success(getWasherPayoutsService.getPayoutsForWasher(washerId));
    }
}
