package com.company.vehiclewash.assignment.repository;

import com.company.vehiclewash.assignment.entity.AssignmentRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface AssignmentRequestRepository extends JpaRepository<AssignmentRequest, UUID> {
}
