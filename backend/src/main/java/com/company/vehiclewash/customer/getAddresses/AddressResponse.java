package com.company.vehiclewash.customer.getAddresses;

import java.math.BigDecimal;
import java.util.UUID;

public class AddressResponse {
    private UUID id;
    private String label;
    private String address;
    private BigDecimal latitude;
    private BigDecimal longitude;
    private Boolean isDefault;

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public BigDecimal getLatitude() { return latitude; }
    public void setLatitude(BigDecimal latitude) { this.latitude = latitude; }

    public BigDecimal getLongitude() { return longitude; }
    public void setLongitude(BigDecimal longitude) { this.longitude = longitude; }

    public Boolean getDefault() { return isDefault; }
    public void setDefault(Boolean isDefault) { this.isDefault = isDefault; }
}
