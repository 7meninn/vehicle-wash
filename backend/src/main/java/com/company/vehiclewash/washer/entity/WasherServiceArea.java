package com.company.vehiclewash.washer.entity;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "washer_service_areas")
public class WasherServiceArea {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "washer_id", nullable = false)
    private UUID washerId;

    @Column(name = "service_area_id", nullable = false)
    private UUID serviceAreaId;

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public UUID getWasherId() { return washerId; }
    public void setWasherId(UUID washerId) { this.washerId = washerId; }

    public UUID getServiceAreaId() { return serviceAreaId; }
    public void setServiceAreaId(UUID serviceAreaId) { this.serviceAreaId = serviceAreaId; }
}
