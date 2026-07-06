package com.company.vehiclewash.washer.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(
    name = "washer_availability",
    uniqueConstraints = @UniqueConstraint(columnNames = {"washer_id", "slot_date", "slot_id"})
)
public class WasherAvailability {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "washer_id", nullable = false)
    private UUID washerId;

    @Column(name = "slot_date", nullable = false)
    private LocalDate slotDate;

    @Column(name = "slot_id", nullable = false)
    private UUID slotId;

    @Column(name = "is_available")
    private Boolean isAvailable = true;

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public UUID getWasherId() { return washerId; }
    public void setWasherId(UUID washerId) { this.washerId = washerId; }

    public LocalDate getSlotDate() { return slotDate; }
    public void setSlotDate(LocalDate slotDate) { this.slotDate = slotDate; }

    public UUID getSlotId() { return slotId; }
    public void setSlotId(UUID slotId) { this.slotId = slotId; }

    public Boolean getAvailable() { return isAvailable; }
    public void setAvailable(Boolean available) { isAvailable = available; }
}
