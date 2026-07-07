package com.company.vehiclewash.booking.history;

import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.payment.enums.PaymentStatus;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

public class BookingHistoryResponse {
    private UUID id;
    private String bookingNumber;
    private UUID customerId;
    private UUID assignedWasherId;
    private BookingStatus bookingStatus;
    private LocalDate bookingDate;
    private Instant scheduledStartTime;
    private Instant scheduledEndTime;
    private PaymentStatus paymentStatus;
    private Instant createdAt;

    // Getters and Setters
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }
    public String getBookingNumber() { return bookingNumber; }
    public void setBookingNumber(String bookingNumber) { this.bookingNumber = bookingNumber; }
    public UUID getCustomerId() { return customerId; }
    public void setCustomerId(UUID customerId) { this.customerId = customerId; }
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
    public PaymentStatus getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(PaymentStatus paymentStatus) { this.paymentStatus = paymentStatus; }
    public Instant getCreatedAt() { return createdAt; }
    public void setCreatedAt(Instant createdAt) { this.createdAt = createdAt; }
}
