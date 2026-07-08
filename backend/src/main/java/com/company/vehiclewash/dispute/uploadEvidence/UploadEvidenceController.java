package com.company.vehiclewash.dispute.uploadEvidence;

import com.company.vehiclewash.common.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@RestController
@RequestMapping("/disputes/{disputeId}/media")
@RequiredArgsConstructor
public class UploadEvidenceController {

    private final UploadEvidenceService uploadEvidenceService;

    @PostMapping(consumes = "multipart/form-data")
    public ResponseEntity<ApiResponse<UploadEvidenceResponse>> uploadEvidence(
            @PathVariable UUID disputeId,
            @RequestParam("file") MultipartFile file) {
        
        UploadEvidenceResponse response = uploadEvidenceService.uploadEvidence(disputeId, file);
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
