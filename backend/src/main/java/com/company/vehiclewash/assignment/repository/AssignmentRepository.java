package com.company.vehiclewash.assignment.repository;

import com.company.vehiclewash.assignment.entity.Assignment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AssignmentRepository extends JpaRepository<Assignment, UUID> {
    Optional<Assignment> findByBookingIdAndWasherId(UUID bookingId, UUID washerId);
    List<Assignment> findByWasherId(UUID washerId);
}
