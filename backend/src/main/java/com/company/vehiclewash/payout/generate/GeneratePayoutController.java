package com.company.vehiclewash.payout.generate;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/admin/payouts")
public class GeneratePayoutController {

    private final GeneratePayoutService generatePayoutService;

    public GeneratePayoutController(GeneratePayoutService generatePayoutService) {
        this.generatePayoutService = generatePayoutService;
    }

    @PostMapping("/generate")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<Map<String, UUID>> generate(@Valid @RequestBody GeneratePayoutRequest request) {
        UUID batchId = generatePayoutService.generatePayout(request);
        Map<String, UUID> data = new HashMap<>();
        data.put("batchId", batchId);
        return ApiResponse.success(data);
    }
}
