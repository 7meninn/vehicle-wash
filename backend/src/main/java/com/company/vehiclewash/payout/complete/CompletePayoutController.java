package com.company.vehiclewash.payout.complete;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/admin/payouts")
public class CompletePayoutController {

    private final CompletePayoutService completePayoutService;

    public CompletePayoutController(CompletePayoutService completePayoutService) {
        this.completePayoutService = completePayoutService;
    }

    @PutMapping("/{batchId}/complete")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<Void> complete(@PathVariable UUID batchId) {
        completePayoutService.completePayout(batchId);
        return ApiResponse.success(null);
    }
}
