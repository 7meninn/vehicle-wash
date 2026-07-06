package com.company.vehiclewash.washer.repository;

import com.company.vehiclewash.washer.entity.Washer;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import java.util.UUID;

public interface WasherRepository extends JpaRepository<Washer, UUID> {
    Optional<Washer> findByMobileNumber(String mobileNumber);
}
