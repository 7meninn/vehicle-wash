package com.company.vehiclewash.dispute.resolveDispute;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/admin/disputes/{disputeId}/resolve")
@RequiredArgsConstructor
public class ResolveDisputeController {

    private final ResolveDisputeService resolveDisputeService;

    @PostMapping
    @PreAuthorize("hasRole('ADMIN') or hasRole('SUPER_ADMIN')")
    public ApiResponse<Void> resolveDispute(
            @PathVariable UUID disputeId,
            @Valid @RequestBody ResolveDisputeRequest request) {
        
        resolveDisputeService.resolveDispute(disputeId, request);
        return ApiResponse.success(null);
    }
}
