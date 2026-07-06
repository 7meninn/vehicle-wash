package com.company.vehiclewash.payment.webhook;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/payments")
public class PaymentWebhookController {

    private final PaymentWebhookService paymentWebhookService;

    public PaymentWebhookController(PaymentWebhookService paymentWebhookService) {
        this.paymentWebhookService = paymentWebhookService;
    }

    @PostMapping("/webhook")
    public ResponseEntity<ApiResponse<Void>> handleWebhook(@Valid @RequestBody PaymentWebhookRequest request) {
        paymentWebhookService.processPaymentWebhook(request);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
