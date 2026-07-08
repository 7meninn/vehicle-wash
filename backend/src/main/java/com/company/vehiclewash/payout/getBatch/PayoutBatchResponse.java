package com.company.vehiclewash.payout.getBatch;

import com.company.vehiclewash.payout.enums.PayoutStatus;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;
import java.util.List;

public class PayoutBatchResponse {
    private UUID id;
    private String batchReference;
    private LocalDate batchStartDate;
    private LocalDate batchEndDate;
    private BigDecimal totalAmount;
    private Integer totalJobs;
    private PayoutStatus payoutStatus;
    private Instant generatedAt;
    private Instant processedAt;
    private List<PayoutItemDto> items;

    // Getters and Setters
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }
    public String getBatchReference() { return batchReference; }
    public void setBatchReference(String batchReference) { this.batchReference = batchReference; }
    public LocalDate getBatchStartDate() { return batchStartDate; }
    public void setBatchStartDate(LocalDate batchStartDate) { this.batchStartDate = batchStartDate; }
    public LocalDate getBatchEndDate() { return batchEndDate; }
    public void setBatchEndDate(LocalDate batchEndDate) { this.batchEndDate = batchEndDate; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public Integer getTotalJobs() { return totalJobs; }
    public void setTotalJobs(Integer totalJobs) { this.totalJobs = totalJobs; }
    public PayoutStatus getPayoutStatus() { return payoutStatus; }
    public void setPayoutStatus(PayoutStatus payoutStatus) { this.payoutStatus = payoutStatus; }
    public Instant getGeneratedAt() { return generatedAt; }
    public void setGeneratedAt(Instant generatedAt) { this.generatedAt = generatedAt; }
    public Instant getProcessedAt() { return processedAt; }
    public void setProcessedAt(Instant processedAt) { this.processedAt = processedAt; }
    public List<PayoutItemDto> getItems() { return items; }
    public void setItems(List<PayoutItemDto> items) { this.items = items; }

    public static class PayoutItemDto {
        private UUID id;
        private UUID washerId;
        private UUID bookingId;
        private BigDecimal payoutAmount;
        private PayoutStatus payoutStatus;

        public UUID getId() { return id; }
        public void setId(UUID id) { this.id = id; }
        public UUID getWasherId() { return washerId; }
        public void setWasherId(UUID washerId) { this.washerId = washerId; }
        public UUID getBookingId() { return bookingId; }
        public void setBookingId(UUID bookingId) { this.bookingId = bookingId; }
        public BigDecimal getPayoutAmount() { return payoutAmount; }
        public void setPayoutAmount(BigDecimal payoutAmount) { this.payoutAmount = payoutAmount; }
        public PayoutStatus getPayoutStatus() { return payoutStatus; }
        public void setPayoutStatus(PayoutStatus payoutStatus) { this.payoutStatus = payoutStatus; }
    }
}
