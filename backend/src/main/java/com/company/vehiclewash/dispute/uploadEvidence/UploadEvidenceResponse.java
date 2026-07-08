package com.company.vehiclewash.dispute.uploadEvidence;

import lombok.Builder;
import lombok.Data;

import java.util.UUID;

@Data
@Builder
public class UploadEvidenceResponse {
    private UUID evidenceId;
    private String storageKey;
}
