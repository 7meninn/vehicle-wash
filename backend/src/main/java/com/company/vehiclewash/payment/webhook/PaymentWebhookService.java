package com.company.vehiclewash.payment.webhook;

import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.event.BookingConfirmedEvent;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.payment.entity.Payment;
import com.company.vehiclewash.payment.enums.PaymentStatus;
import com.company.vehiclewash.payment.repository.PaymentRepository;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;

@Service
public class PaymentWebhookService {

    private final PaymentRepository paymentRepository;
    private final BookingRepository bookingRepository;
    private final ApplicationEventPublisher eventPublisher;

    public PaymentWebhookService(
            PaymentRepository paymentRepository,
            BookingRepository bookingRepository,
            ApplicationEventPublisher eventPublisher) {
        this.paymentRepository = paymentRepository;
        this.bookingRepository = bookingRepository;
        this.eventPublisher = eventPublisher;
    }

    @Transactional
    public void processPaymentWebhook(PaymentWebhookRequest request) {
        Payment payment = paymentRepository.findByGatewayOrderId(request.getOrderId())
                .orElseThrow(() -> new RuntimeException("Payment not found for Order ID: " + request.getOrderId()));

        if ("SUCCESS".equalsIgnoreCase(request.getStatus())) {
            payment.setPaymentStatus(PaymentStatus.CAPTURED);
            payment.setGatewayPaymentId(request.getPaymentId());
            payment.setGatewaySignature(request.getSignature());
            payment.setPaidAt(Instant.now());
            paymentRepository.save(payment);

            Booking booking = bookingRepository.findById(payment.getBookingId())
                    .orElseThrow(() -> new RuntimeException("Booking not found for Payment"));

            booking.setBookingStatus(BookingStatus.CONFIRMED);
            booking.setPaymentStatus(PaymentStatus.CAPTURED);
            bookingRepository.save(booking);

            // Trigger domain event
            eventPublisher.publishEvent(new BookingConfirmedEvent(booking.getId()));
        } else {
            payment.setPaymentStatus(PaymentStatus.FAILED);
            paymentRepository.save(payment);

            Booking booking = bookingRepository.findById(payment.getBookingId())
                    .orElseThrow(() -> new RuntimeException("Booking not found for Payment"));
            
            booking.setBookingStatus(BookingStatus.FAILED);
            booking.setPaymentStatus(PaymentStatus.FAILED);
            bookingRepository.save(booking);
        }
    }
}
