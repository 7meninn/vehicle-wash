package com.company.vehiclewash.washer.servicearea;

import java.util.UUID;

public class ServiceAreaResponse {
    private UUID id;
    private String name;
    private String polygonGeojson;
    private Boolean isActive;

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPolygonGeojson() { return polygonGeojson; }
    public void setPolygonGeojson(String polygonGeojson) { this.polygonGeojson = polygonGeojson; }

    public Boolean getActive() { return isActive; }
    public void setActive(Boolean active) { isActive = active; }
}
