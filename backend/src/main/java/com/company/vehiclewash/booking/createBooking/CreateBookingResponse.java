package com.company.vehiclewash.booking.createBooking;

import java.math.BigDecimal;
import java.util.UUID;

public class CreateBookingResponse {
    private UUID bookingId;
    private String bookingNumber;
    private PaymentDetails payment;

    public UUID getBookingId() { return bookingId; }
    public void setBookingId(UUID bookingId) { this.bookingId = bookingId; }

    public String getBookingNumber() { return bookingNumber; }
    public void setBookingNumber(String bookingNumber) { this.bookingNumber = bookingNumber; }

    public PaymentDetails getPayment() { return payment; }
    public void setPayment(PaymentDetails payment) { this.payment = payment; }

    public static class PaymentDetails {
        private String gateway;
        private String orderId;
        private BigDecimal amount;

        public String getGateway() { return gateway; }
        public void setGateway(String gateway) { this.gateway = gateway; }

        public String getOrderId() { return orderId; }
        public void setOrderId(String orderId) { this.orderId = orderId; }

        public BigDecimal getAmount() { return amount; }
        public void setAmount(BigDecimal amount) { this.amount = amount; }
    }
}
