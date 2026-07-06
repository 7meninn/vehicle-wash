package com.company.vehiclewash.booking.createBooking;

import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.UUID;

public class CreateBookingRequest {
    @NotNull(message = "Vehicle ID is required")
    private UUID vehicleId;

    @NotNull(message = "Address ID is required")
    private UUID addressId;

    @NotNull(message = "Slot ID is required")
    private UUID slotId;

    @NotNull(message = "Booking date is required")
    private LocalDate bookingDate;

    public UUID getVehicleId() { return vehicleId; }
    public void setVehicleId(UUID vehicleId) { this.vehicleId = vehicleId; }

    public UUID getAddressId() { return addressId; }
    public void setAddressId(UUID addressId) { this.addressId = addressId; }

    public UUID getSlotId() { return slotId; }
    public void setSlotId(UUID slotId) { this.slotId = slotId; }

    public LocalDate getBookingDate() { return bookingDate; }
    public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }
}
