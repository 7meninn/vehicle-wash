package com.company.vehiclewash.payout.washer;

import com.company.vehiclewash.payout.entity.PayoutItem;
import com.company.vehiclewash.payout.repository.PayoutItemRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class GetWasherPayoutsService {

    private final PayoutItemRepository payoutItemRepository;

    public GetWasherPayoutsService(PayoutItemRepository payoutItemRepository) {
        this.payoutItemRepository = payoutItemRepository;
    }

    @Transactional(readOnly = true)
    public List<WasherPayoutResponse> getPayoutsForWasher(UUID washerId) {
        return payoutItemRepository.findByWasherId(washerId).stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    private WasherPayoutResponse mapToResponse(PayoutItem item) {
        WasherPayoutResponse res = new WasherPayoutResponse();
        res.setId(item.getId());
        res.setPayoutBatchId(item.getPayoutBatchId());
        res.setBookingId(item.getBookingId());
        res.setPayoutAmount(item.getPayoutAmount());
        res.setPayoutStatus(item.getPayoutStatus());
        res.setTransferredAt(item.getTransferredAt());
        res.setTransactionReference(item.getTransactionReference());
        return res;
    }
}
