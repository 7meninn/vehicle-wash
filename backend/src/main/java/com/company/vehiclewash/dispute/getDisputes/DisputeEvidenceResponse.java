package com.company.vehiclewash.dispute.getDisputes;

import com.company.vehiclewash.dispute.enums.UploadedBy;
import com.company.vehiclewash.media.enums.MediaType;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
public class DisputeEvidenceResponse {
    private UUID id;
    private UploadedBy uploadedBy;
    private MediaType mediaType;
    private String storageKey;
    private LocalDateTime uploadedAt;
}
