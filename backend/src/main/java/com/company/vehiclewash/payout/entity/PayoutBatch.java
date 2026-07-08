package com.company.vehiclewash.payout.entity;

import com.company.vehiclewash.payout.enums.PayoutStatus;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;
import java.util.List;

@Entity
@Table(name = "payout_batches")
public class PayoutBatch {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "batch_reference", unique = true, length = 50)
    private String batchReference;

    @Column(name = "batch_start_date")
    private LocalDate batchStartDate;

    @Column(name = "batch_end_date")
    private LocalDate batchEndDate;

    @Column(name = "total_amount")
    private BigDecimal totalAmount;

    @Column(name = "total_jobs")
    private Integer totalJobs;

    @Enumerated(EnumType.STRING)
    @Column(name = "payout_status")
    private PayoutStatus payoutStatus;

    @Column(name = "generated_at")
    private Instant generatedAt;

    @Column(name = "processed_at")
    private Instant processedAt;
    
    @OneToMany(mappedBy = "payoutBatchId", cascade = CascadeType.ALL)
    private List<PayoutItem> items;

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

    public List<PayoutItem> getItems() { return items; }
    public void setItems(List<PayoutItem> items) { this.items = items; }
}
