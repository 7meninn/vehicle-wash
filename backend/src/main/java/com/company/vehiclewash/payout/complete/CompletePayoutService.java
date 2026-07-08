package com.company.vehiclewash.payout.complete;

import com.company.vehiclewash.payout.entity.PayoutBatch;
import com.company.vehiclewash.payout.entity.PayoutItem;
import com.company.vehiclewash.payout.enums.PayoutStatus;
import com.company.vehiclewash.payout.repository.PayoutBatchRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.UUID;

@Service
public class CompletePayoutService {

    private final PayoutBatchRepository payoutBatchRepository;

    public CompletePayoutService(PayoutBatchRepository payoutBatchRepository) {
        this.payoutBatchRepository = payoutBatchRepository;
    }

    @Transactional
    public void completePayout(UUID batchId) {
        PayoutBatch batch = payoutBatchRepository.findById(batchId)
                .orElseThrow(() -> new RuntimeException("Payout batch not found"));
        
        batch.setPayoutStatus(PayoutStatus.COMPLETED);
        batch.setProcessedAt(Instant.now());
        
        if (batch.getItems() != null) {
            for (PayoutItem item : batch.getItems()) {
                item.setPayoutStatus(PayoutStatus.COMPLETED);
                item.setTransferredAt(Instant.now());
            }
        }
        
        payoutBatchRepository.save(batch);
    }
}
