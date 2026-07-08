package com.company.vehiclewash.dispute.getDisputes;

import com.company.vehiclewash.common.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class GetDisputesController {

    private final GetDisputesService getDisputesService;

    @GetMapping("/disputes/{disputeId}")
    public ApiResponse<DisputeResponse> getDispute(@PathVariable UUID disputeId) {
        return ApiResponse.success(getDisputesService.getDispute(disputeId));
    }

    @GetMapping("/admin/disputes")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SUPER_ADMIN')")
    public ApiResponse<Page<DisputeResponse>> getAllDisputes(Pageable pageable) {
        return ApiResponse.success(getDisputesService.getAllDisputes(pageable));
    }
    
    @GetMapping("/admin/disputes/{disputeId}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('SUPER_ADMIN')")
    public ApiResponse<DisputeResponse> getAdminDispute(@PathVariable UUID disputeId) {
        return ApiResponse.success(getDisputesService.getDispute(disputeId));
    }
}
