package com.company.vehiclewash.customer.getVehicles;

import com.company.vehiclewash.customer.enums.VehicleType;
import java.util.UUID;

public class VehicleResponse {
    private UUID id;
    private VehicleType vehicleType;
    private String vehicleNumber;
    private String vehicleBrand;
    private String vehicleModel;
    private String vehicleColor;
    private Boolean isDefault;

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public VehicleType getVehicleType() { return vehicleType; }
    public void setVehicleType(VehicleType vehicleType) { this.vehicleType = vehicleType; }

    public String getVehicleNumber() { return vehicleNumber; }
    public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }

    public String getVehicleBrand() { return vehicleBrand; }
    public void setVehicleBrand(String vehicleBrand) { this.vehicleBrand = vehicleBrand; }

    public String getVehicleModel() { return vehicleModel; }
    public void setVehicleModel(String vehicleModel) { this.vehicleModel = vehicleModel; }

    public String getVehicleColor() { return vehicleColor; }
    public void setVehicleColor(String vehicleColor) { this.vehicleColor = vehicleColor; }

    public Boolean getDefault() { return isDefault; }
    public void setDefault(Boolean isDefault) { this.isDefault = isDefault; }
}
