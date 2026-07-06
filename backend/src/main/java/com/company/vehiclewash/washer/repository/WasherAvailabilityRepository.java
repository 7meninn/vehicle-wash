package com.company.vehiclewash.washer.repository;

import com.company.vehiclewash.washer.entity.WasherAvailability;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface WasherAvailabilityRepository extends JpaRepository<WasherAvailability, UUID> {
    List<WasherAvailability> findByWasherIdAndSlotDateBetween(UUID washerId, LocalDate fromDate, LocalDate toDate);
    Optional<WasherAvailability> findByWasherIdAndSlotDateAndSlotId(UUID washerId, LocalDate slotDate, UUID slotId);
}
