package com.company.vehiclewash.payout.repository;

import com.company.vehiclewash.payout.entity.PayoutItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface PayoutItemRepository extends JpaRepository<PayoutItem, UUID> {
    List<PayoutItem> findByWasherId(UUID washerId);
    List<PayoutItem> findByPayoutBatchId(UUID payoutBatchId);
}
