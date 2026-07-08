package com.company.vehiclewash.payment.repository;

import com.company.vehiclewash.payment.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import java.util.UUID;

public interface PaymentRepository extends JpaRepository<Payment, UUID> {
    Optional<Payment> findByGatewayOrderId(String gatewayOrderId);
    Optional<Payment> findByBookingId(UUID bookingId);
}
