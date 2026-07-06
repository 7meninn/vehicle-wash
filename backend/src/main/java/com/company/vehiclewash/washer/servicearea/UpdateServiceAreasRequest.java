package com.company.vehiclewash.washer.servicearea;

import jakarta.validation.constraints.NotNull;
import java.util.List;
import java.util.UUID;

public class UpdateServiceAreasRequest {

    @NotNull(message = "Service Area IDs list cannot be null")
    private List<UUID> serviceAreaIds;

    public List<UUID> getServiceAreaIds() { return serviceAreaIds; }
    public void setServiceAreaIds(List<UUID> serviceAreaIds) { this.serviceAreaIds = serviceAreaIds; }
}
