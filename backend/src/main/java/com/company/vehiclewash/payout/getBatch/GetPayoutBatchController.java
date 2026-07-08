package com.company.vehiclewash.payout.getBatch;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/admin/payouts")
public class GetPayoutBatchController {

    private final GetPayoutBatchService getPayoutBatchService;

    public GetPayoutBatchController(GetPayoutBatchService getPayoutBatchService) {
        this.getPayoutBatchService = getPayoutBatchService;
    }

    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<List<PayoutBatchResponse>> getAll() {
        return ApiResponse.success(getPayoutBatchService.getAllBatches());
    }

    @GetMapping("/{batchId}")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<PayoutBatchResponse> getById(@PathVariable UUID batchId) {
        return ApiResponse.success(getPayoutBatchService.getBatch(batchId));
    }
}
