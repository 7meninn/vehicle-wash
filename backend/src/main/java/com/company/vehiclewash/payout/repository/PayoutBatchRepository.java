package com.company.vehiclewash.payout.repository;

import com.company.vehiclewash.payout.entity.PayoutBatch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface PayoutBatchRepository extends JpaRepository<PayoutBatch, UUID> {
}
