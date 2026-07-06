package com.company.vehiclewash.washer.availability;

import jakarta.validation.constraints.NotNull;
import java.util.UUID;

public class SlotAvailabilityRequest {
    @NotNull(message = "Slot ID is required")
    private UUID slotId;

    @NotNull(message = "Availability status is required")
    private Boolean available;

    public UUID getSlotId() { return slotId; }
    public void setSlotId(UUID slotId) { this.slotId = slotId; }

    public Boolean getAvailable() { return available; }
    public void setAvailable(Boolean available) { this.available = available; }
}
