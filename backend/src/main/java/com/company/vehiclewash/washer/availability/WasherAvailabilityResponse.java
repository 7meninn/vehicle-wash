package com.company.vehiclewash.washer.availability;

import java.time.LocalDate;
import java.util.UUID;

public class WasherAvailabilityResponse {
    private LocalDate slotDate;
    private UUID slotId;
    private Boolean isAvailable;

    public LocalDate getSlotDate() { return slotDate; }
    public void setSlotDate(LocalDate slotDate) { this.slotDate = slotDate; }

    public UUID getSlotId() { return slotId; }
    public void setSlotId(UUID slotId) { this.slotId = slotId; }

    public Boolean getAvailable() { return isAvailable; }
    public void setAvailable(Boolean available) { isAvailable = available; }
}
