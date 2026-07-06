package com.company.vehiclewash.booking.entity;

import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.enums.CancellationBy;
import com.company.vehiclewash.payment.enums.PaymentStatus;
import jakarta.persistence.*;
import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "bookings")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "booking_number", unique = true, length = 30)
    private String bookingNumber;

    @Column(name = "customer_id")
    private UUID customerId;

    @Column(name = "vehicle_id")
    private UUID vehicleId;

    @Column(name = "address_id")
    private UUID addressId;

    @Column(name = "slot_id")
    private UUID slotId;

    @Column(name = "assigned_washer_id")
    private UUID assignedWasherId;

    @Enumerated(EnumType.STRING)
    @Column(name = "booking_status")
    private BookingStatus bookingStatus;

    @Column(name = "booking_date")
    private LocalDate bookingDate;

    @Column(name = "scheduled_start_time")
    private Instant scheduledStartTime;

    @Column(name = "scheduled_end_time")
    private Instant scheduledEndTime;

    @Column(name = "wash_started_at")
    private Instant washStartedAt;

    @Column(name = "completed_at")
    private Instant completedAt;

    @Column(name = "cancelled_at")
    private Instant cancelledAt;

    @Column(name = "cancellation_reason", columnDefinition = "TEXT")
    private String cancellationReason;

    @Enumerated(EnumType.STRING)
    @Column(name = "cancellation_by")
    private CancellationBy cancellationBy;

    @Column(name = "dispute_deadline")
    private Instant disputeDeadline;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private PaymentStatus paymentStatus;

    @Column(name = "has_dispute")
    private Boolean hasDispute = false;

    @Column(name = "created_at", nullable = false, updatable = false)
    private Instant createdAt = Instant.now();

    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt = Instant.now();

    @Version
    @Column(name = "version")
    private Integer version;

    @PrePersist
    protected void onCreate() {
        createdAt = Instant.now();
        updatedAt = Instant.now();
        if (bookingNumber == null) {
            bookingNumber = "BK-" + System.currentTimeMillis(); // Simple mock booking number
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = Instant.now();
    }

    // Getters and Setters

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getBookingNumber() { return bookingNumber; }
    public void setBookingNumber(String bookingNumber) { this.bookingNumber = bookingNumber; }

    public UUID getCustomerId() { return customerId; }
    public void setCustomerId(UUID customerId) { this.customerId = customerId; }

    public UUID getVehicleId() { return vehicleId; }
    public void setVehicleId(UUID vehicleId) { this.vehicleId = vehicleId; }

    public UUID getAddressId() { return addressId; }
    public void setAddressId(UUID addressId) { this.addressId = addressId; }

    public UUID getSlotId() { return slotId; }
    public void setSlotId(UUID slotId) { this.slotId = slotId; }

    public UUID getAssignedWasherId() { return assignedWasherId; }
    public void setAssignedWasherId(UUID assignedWasherId) { this.assignedWasherId = assignedWasherId; }

    public BookingStatus getBookingStatus() { return bookingStatus; }
    public void setBookingStatus(BookingStatus bookingStatus) { this.bookingStatus = bookingStatus; }

    public LocalDate getBookingDate() { return bookingDate; }
    public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }

    public Instant getScheduledStartTime() { return scheduledStartTime; }
    public void setScheduledStartTime(Instant scheduledStartTime) { this.scheduledStartTime = scheduledStartTime; }

    public Instant getScheduledEndTime() { return scheduledEndTime; }
    public void setScheduledEndTime(Instant scheduledEndTime) { this.scheduledEndTime = scheduledEndTime; }

    public Instant getWashStartedAt() { return washStartedAt; }
    public void setWashStartedAt(Instant washStartedAt) { this.washStartedAt = washStartedAt; }

    public Instant getCompletedAt() { return completedAt; }
    public void setCompletedAt(Instant completedAt) { this.completedAt = completedAt; }

    public Instant getCancelledAt() { return cancelledAt; }
    public void setCancelledAt(Instant cancelledAt) { this.cancelledAt = cancelledAt; }

    public String getCancellationReason() { return cancellationReason; }
    public void setCancellationReason(String cancellationReason) { this.cancellationReason = cancellationReason; }

    public CancellationBy getCancellationBy() { return cancellationBy; }
    public void setCancellationBy(CancellationBy cancellationBy) { this.cancellationBy = cancellationBy; }

    public Instant getDisputeDeadline() { return disputeDeadline; }
    public void setDisputeDeadline(Instant disputeDeadline) { this.disputeDeadline = disputeDeadline; }

    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }

    public Boolean getHasDispute() { return hasDispute; }
    public void setHasDispute(Boolean hasDispute) { this.hasDispute = hasDispute; }

    public Instant getCreatedAt() { return createdAt; }
    public void setCreatedAt(Instant createdAt) { this.createdAt = createdAt; }

    public Instant getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Instant updatedAt) { this.updatedAt = updatedAt; }

    public Integer getVersion() { return version; }
    public void setVersion(Integer version) { this.version = version; }
}
