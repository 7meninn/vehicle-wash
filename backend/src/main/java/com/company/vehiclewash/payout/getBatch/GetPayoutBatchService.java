package com.company.vehiclewash.payout.getBatch;

import com.company.vehiclewash.payout.entity.PayoutBatch;
import com.company.vehiclewash.payout.repository.PayoutBatchRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class GetPayoutBatchService {

    private final PayoutBatchRepository payoutBatchRepository;
    
    public GetPayoutBatchService(PayoutBatchRepository payoutBatchRepository) {
        this.payoutBatchRepository = payoutBatchRepository;
    }

    @Transactional(readOnly = true)
    public List<PayoutBatchResponse> getAllBatches() {
        return payoutBatchRepository.findAll().stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public PayoutBatchResponse getBatch(UUID batchId) {
        PayoutBatch batch = payoutBatchRepository.findById(batchId)
                .orElseThrow(() -> new RuntimeException("Payout batch not found"));
        return mapToResponse(batch);
    }

    private PayoutBatchResponse mapToResponse(PayoutBatch batch) {
        PayoutBatchResponse response = new PayoutBatchResponse();
        response.setId(batch.getId());
        response.setBatchReference(batch.getBatchReference());
        response.setBatchStartDate(batch.getBatchStartDate());
        response.setBatchEndDate(batch.getBatchEndDate());
        response.setTotalAmount(batch.getTotalAmount());
        response.setTotalJobs(batch.getTotalJobs());
        response.setPayoutStatus(batch.getPayoutStatus());
        response.setGeneratedAt(batch.getGeneratedAt());
        response.setProcessedAt(batch.getProcessedAt());

        if (batch.getItems() != null) {
            response.setItems(batch.getItems().stream().map(item -> {
                PayoutBatchResponse.PayoutItemDto dto = new PayoutBatchResponse.PayoutItemDto();
                dto.setId(item.getId());
                dto.setWasherId(item.getWasherId());
                dto.setBookingId(item.getBookingId());
                dto.setPayoutAmount(item.getPayoutAmount());
                dto.setPayoutStatus(item.getPayoutStatus());
                return dto;
            }).collect(Collectors.toList()));
        }
        return response;
    }
}
