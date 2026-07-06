package com.company.vehiclewash.washer.entity;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "service_areas")
public class ServiceArea {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "name", length = 100)
    private String name;

    @Column(name = "polygon_geojson", columnDefinition = "TEXT")
    private String polygonGeojson; // Using TEXT/String instead of JSONB for simplicity in H2/tests

    @Column(name = "is_active")
    private Boolean isActive = true;

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPolygonGeojson() { return polygonGeojson; }
    public void setPolygonGeojson(String polygonGeojson) { this.polygonGeojson = polygonGeojson; }

    public Boolean getActive() { return isActive; }
    public void setActive(Boolean active) { isActive = active; }
}
