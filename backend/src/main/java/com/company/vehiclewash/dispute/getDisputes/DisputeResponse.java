package com.company.vehiclewash.dispute.getDisputes;

import com.company.vehiclewash.dispute.enums.DisputeStatus;
import com.company.vehiclewash.dispute.enums.DisputeType;
import com.company.vehiclewash.dispute.enums.RaisedBy;
import com.company.vehiclewash.dispute.enums.ResolutionType;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
@Builder
public class DisputeResponse {
    private UUID id;
    private UUID bookingId;
    private DisputeType disputeType;
    private RaisedBy raisedBy;
    private DisputeStatus disputeStatus;
    private String issueDescription;
    private String adminResolution;
    private ResolutionType resolutionType;
    private BigDecimal refundPercentage;
    private BigDecimal payoutPercentage;
    private UUID resolvedBy;
    private LocalDateTime resolvedAt;
    private LocalDateTime createdAt;
    private List<DisputeEvidenceResponse> evidenceList;
}
