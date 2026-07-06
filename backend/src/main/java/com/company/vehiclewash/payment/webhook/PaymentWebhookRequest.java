package com.company.vehiclewash.payment.webhook;

import jakarta.validation.constraints.NotBlank;

public class PaymentWebhookRequest {
    
    @NotBlank(message = "Order ID is required")
    private String orderId;

    @NotBlank(message = "Payment ID is required")
    private String paymentId;

    @NotBlank(message = "Signature is required")
    private String signature;

    @NotBlank(message = "Status is required")
    private String status; // e.g. "SUCCESS", "FAILED"

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

    public String getSignature() { return signature; }
    public void setSignature(String signature) { this.signature = signature; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
