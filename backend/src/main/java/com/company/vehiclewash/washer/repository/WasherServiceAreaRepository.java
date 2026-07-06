package com.company.vehiclewash.washer.repository;

import com.company.vehiclewash.washer.entity.WasherServiceArea;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;

public interface WasherServiceAreaRepository extends JpaRepository<WasherServiceArea, UUID> {
    List<WasherServiceArea> findByWasherId(UUID washerId);
    void deleteByWasherId(UUID washerId);
}
