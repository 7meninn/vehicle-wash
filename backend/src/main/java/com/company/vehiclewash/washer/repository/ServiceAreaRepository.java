package com.company.vehiclewash.washer.repository;

import com.company.vehiclewash.washer.entity.ServiceArea;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface ServiceAreaRepository extends JpaRepository<ServiceArea, UUID> {
}
