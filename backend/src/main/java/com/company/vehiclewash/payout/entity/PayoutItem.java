package com.company.vehiclewash.payout.entity;

import com.company.vehiclewash.payout.enums.PayoutStatus;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "payout_items")
public class PayoutItem {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "payout_batch_id")
    private UUID payoutBatchId;

    @Column(name = "washer_id")
    private UUID washerId;

    @Column(name = "booking_id")
    private UUID bookingId;

    @Column(name = "payout_amount")
    private BigDecimal payoutAmount;

    @Enumerated(EnumType.STRING)
    @Column(name = "payout_status")
    private PayoutStatus payoutStatus;

    @Column(name = "transferred_at")
    private Instant transferredAt;

    @Column(name = "transaction_reference", length = 150)
    private String transactionReference;

    // Getters and Setters
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public UUID getPayoutBatchId() { return payoutBatchId; }
    public void setPayoutBatchId(UUID payoutBatchId) { this.payoutBatchId = payoutBatchId; }

    public UUID getWasherId() { return washerId; }
    public void setWasherId(UUID washerId) { this.washerId = washerId; }

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
