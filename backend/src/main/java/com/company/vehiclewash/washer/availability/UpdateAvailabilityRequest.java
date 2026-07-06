package com.company.vehiclewash.washer.availability;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.List;

public class UpdateAvailabilityRequest {
    
    @NotNull(message = "Date is required")
    private LocalDate date;

    @NotEmpty(message = "Slots cannot be empty")
    @Valid
    private List<SlotAvailabilityRequest> slots;

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public List<SlotAvailabilityRequest> getSlots() { return slots; }
    public void setSlots(List<SlotAvailabilityRequest> slots) { this.slots = slots; }
}
