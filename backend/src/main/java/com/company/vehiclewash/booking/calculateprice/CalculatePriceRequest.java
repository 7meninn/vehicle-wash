package com.company.vehiclewash.booking.calculateprice;

import jakarta.validation.constraints.NotNull;
import java.util.UUID;

public class CalculatePriceRequest {
    @NotNull(message = "Vehicle ID is required")
    private UUID vehicleId;

    @NotNull(message = "Address ID is required")
    private UUID addressId;

    public UUID getVehicleId() { return vehicleId; }
    public void setVehicleId(UUID vehicleId) { this.vehicleId = vehicleId; }

    public UUID getAddressId() { return addressId; }
    public void setAddressId(UUID addressId) { this.addressId = addressId; }
}
