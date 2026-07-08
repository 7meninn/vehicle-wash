package com.company.vehiclewash.payout.washer;

import com.company.vehiclewash.payout.enums.PayoutStatus;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

public class WasherPayoutResponse {
    private UUID id;
    private UUID payoutBatchId;
    private UUID bookingId;
    private BigDecimal payoutAmount;
    private PayoutStatus payoutStatus;
    private Instant transferredAt;
    private String transactionReference;

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }
    public UUID getPayoutBatchId() { return payoutBatchId; }
    public void setPayoutBatchId(UUID payoutBatchId) { this.payoutBatchId = payoutBatchId; }
    public UUID getBookingId() { return bookingId; }
    public void setBookingId(UUID bookingId) { this.bookingId = bookingId; }
    public BigDecimal getPayoutAmount() { return payoutAmount; }
    public void setPayoutAmount(BigDecimal payoutAmount) { this.payoutAmount = payoutAmount; }
    public PayoutStatus getPayoutStatus() { return payoutStatus; }
    public void setPayoutStatus(PayoutStatus payoutStatus) { this.payoutStatus = payoutStatus; }
    public Instant getTransferredAt() { return transferredAt; }
    public void setTransferredAt(Instant transferredAt) { this.transferredAt = transferredAt; }
    public String getTransactionReference() { return transactionReference; }
    public void setTransactionReference(String transactionReference) { this.transactionReference = transactionReference; }
}
