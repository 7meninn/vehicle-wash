package com.company.vehiclewash.dispute.uploadEvidence;

import com.company.vehiclewash.common.exception.ResourceNotFoundException;
import com.company.vehiclewash.dispute.entity.Dispute;
import com.company.vehiclewash.dispute.entity.DisputeEvidence;
import com.company.vehiclewash.dispute.enums.UploadedBy;
import com.company.vehiclewash.dispute.repository.DisputeEvidenceRepository;
import com.company.vehiclewash.dispute.repository.DisputeRepository;
import com.company.vehiclewash.media.enums.MediaType;
import com.company.vehiclewash.security.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UploadEvidenceService {

    private final DisputeRepository disputeRepository;
    private final DisputeEvidenceRepository disputeEvidenceRepository;

    @Transactional
    public UploadEvidenceResponse uploadEvidence(UUID disputeId, MultipartFile file) {
        Dispute dispute = disputeRepository.findById(disputeId)
                .orElseThrow(() -> new ResourceNotFoundException("Dispute not found"));

        UploadedBy uploadedBy = SecurityUtils.hasRole("WASHER") ? UploadedBy.WASHER : UploadedBy.CUSTOMER;
        if (SecurityUtils.hasRole("ADMIN")) {
            uploadedBy = UploadedBy.ADMIN;
        }

        // Mocking S3 storage for MVP
        String originalFilename = file.getOriginalFilename();
        String storageKey = "disputes/" + disputeId + "/evidence_" + System.currentTimeMillis() + "_" + originalFilename;

        DisputeEvidence evidence = DisputeEvidence.builder()
                .dispute(dispute)
                .uploadedBy(uploadedBy)
                .mediaType(MediaType.DISPUTE_EVIDENCE)
                .storageKey(storageKey)
                .build();

        disputeEvidenceRepository.save(evidence);

        return UploadEvidenceResponse.builder()
                .evidenceId(evidence.getId())
                .storageKey(storageKey)
                .build();
    }
}
