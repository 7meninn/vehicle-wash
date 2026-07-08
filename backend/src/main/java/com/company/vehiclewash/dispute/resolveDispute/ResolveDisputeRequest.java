package com.company.vehiclewash.dispute.resolveDispute;

import com.company.vehiclewash.dispute.enums.ResolutionType;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class ResolveDisputeRequest {
    
    @NotNull(message = "Resolution type is required")
    private ResolutionType resolutionType;
    
    private BigDecimal refundPercentage;
    
    private BigDecimal payoutPercentage;
    
    private String adminNotes;
}
