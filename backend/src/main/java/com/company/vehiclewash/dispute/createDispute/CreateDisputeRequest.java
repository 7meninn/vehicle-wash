package com.company.vehiclewash.dispute.createDispute;

import com.company.vehiclewash.dispute.enums.DisputeType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CreateDisputeRequest {

    @NotNull(message = "Dispute type is required")
    private DisputeType type;

    @NotBlank(message = "Description is required")
    private String description;
}
