package com.company.vehiclewash.dispute.getDisputes;

import com.company.vehiclewash.common.exception.ResourceNotFoundException;
import com.company.vehiclewash.dispute.entity.Dispute;
import com.company.vehiclewash.dispute.repository.DisputeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GetDisputesService {

    private final DisputeRepository disputeRepository;

    @Transactional(readOnly = true)
    public DisputeResponse getDispute(UUID disputeId) {
        Dispute dispute = disputeRepository.findById(disputeId)
                .orElseThrow(() -> new ResourceNotFoundException("Dispute not found"));
        return mapToResponse(dispute);
    }

    @Transactional(readOnly = true)
    public Page<DisputeResponse> getAllDisputes(Pageable pageable) {
        return disputeRepository.findAll(pageable).map(this::mapToResponse);
    }

    private DisputeResponse mapToResponse(Dispute dispute) {
        return DisputeResponse.builder()
                .id(dispute.getId())
                .bookingId(dispute.getBookingId())
                .disputeType(dispute.getDisputeType())
                .raisedBy(dispute.getRaisedBy())
                .disputeStatus(dispute.getDisputeStatus())
                .issueDescription(dispute.getIssueDescription())
                .adminResolution(dispute.getAdminResolution())
                .resolutionType(dispute.getResolutionType())
                .refundPercentage(dispute.getRefundPercentage())
                .payoutPercentage(dispute.getPayoutPercentage())
                .resolvedBy(dispute.getResolvedBy())
                .resolvedAt(dispute.getResolvedAt())
                .createdAt(dispute.getCreatedAt())
                .evidenceList(dispute.getEvidenceList().stream().map(e -> DisputeEvidenceResponse.builder()
                        .id(e.getId())
                        .uploadedBy(e.getUploadedBy())
                        .mediaType(e.getMediaType())
                        .storageKey(e.getStorageKey())
                        .uploadedAt(e.getUploadedAt())
                        .build()).collect(Collectors.toList()))
                .build();
    }
}
