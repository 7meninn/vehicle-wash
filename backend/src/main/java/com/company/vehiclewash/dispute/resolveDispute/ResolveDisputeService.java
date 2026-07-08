package com.company.vehiclewash.dispute.resolveDispute;

import com.company.vehiclewash.common.exception.ResourceNotFoundException;
import com.company.vehiclewash.dispute.entity.Dispute;
import com.company.vehiclewash.dispute.enums.DisputeStatus;
import com.company.vehiclewash.dispute.repository.DisputeRepository;
import com.company.vehiclewash.security.SecurityUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class ResolveDisputeService {

    private final DisputeRepository disputeRepository;

    @Transactional
    public void resolveDispute(UUID disputeId, ResolveDisputeRequest request) {
        Dispute dispute = disputeRepository.findById(disputeId)
                .orElseThrow(() -> new ResourceNotFoundException("Dispute not found"));

        if (dispute.getDisputeStatus() == DisputeStatus.RESOLVED) {
            throw new RuntimeException("Dispute is already resolved");
        }

        dispute.setDisputeStatus(DisputeStatus.RESOLVED);
        dispute.setResolutionType(request.getResolutionType());
        dispute.setRefundPercentage(request.getRefundPercentage());
        dispute.setPayoutPercentage(request.getPayoutPercentage());
        dispute.setAdminResolution(request.getAdminNotes());
        
        dispute.setResolvedBy(SecurityUtils.getCurrentUserId());
        dispute.setResolvedAt(LocalDateTime.now());

        disputeRepository.save(dispute);
        
        log.info("Dispute {} resolved with type: {}", disputeId, request.getResolutionType());
    }
}
