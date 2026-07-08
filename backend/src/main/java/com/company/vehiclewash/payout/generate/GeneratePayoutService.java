package com.company.vehiclewash.payout.generate;

import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.payment.entity.Payment;
import com.company.vehiclewash.payment.repository.PaymentRepository;
import com.company.vehiclewash.payout.entity.PayoutBatch;
import com.company.vehiclewash.payout.entity.PayoutItem;
import com.company.vehiclewash.payout.enums.PayoutStatus;
import com.company.vehiclewash.payout.repository.PayoutBatchRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class GeneratePayoutService {

    private final PayoutBatchRepository payoutBatchRepository;
    private final BookingRepository bookingRepository;
    private final PaymentRepository paymentRepository;

    public GeneratePayoutService(PayoutBatchRepository payoutBatchRepository, 
                                 BookingRepository bookingRepository,
                                 PaymentRepository paymentRepository) {
        this.payoutBatchRepository = payoutBatchRepository;
        this.bookingRepository = bookingRepository;
        this.paymentRepository = paymentRepository;
    }

    @Transactional
    public UUID generatePayout(GeneratePayoutRequest request) {
        Instant start = request.getStartDate().atStartOfDay().toInstant(ZoneOffset.UTC);
        Instant end = request.getEndDate().plusDays(1).atStartOfDay().toInstant(ZoneOffset.UTC);

        List<Booking> completedBookings = bookingRepository.findByBookingStatusAndCompletedAtBetween(BookingStatus.COMPLETED, start, end);

        PayoutBatch batch = new PayoutBatch();
        batch.setBatchReference("B-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
        batch.setBatchStartDate(request.getStartDate());
        batch.setBatchEndDate(request.getEndDate());
        batch.setPayoutStatus(PayoutStatus.PENDING);
        batch.setGeneratedAt(Instant.now());
        
        List<PayoutItem> items = new ArrayList<>();
        BigDecimal totalAmount = BigDecimal.ZERO;
        int jobs = 0;

        for (Booking booking : completedBookings) {
            // Check if there is a payment
            Payment payment = paymentRepository.findByBookingId(booking.getId()).orElse(null);
            if (payment == null || booking.getAssignedWasherId() == null) {
                continue;
            }
            
            // For MVP, assuming 80% of amount goes to Washer if price breakdown not available
            BigDecimal amount = payment.getAmount().multiply(new BigDecimal("0.80")).setScale(2, java.math.RoundingMode.HALF_UP);
            
            PayoutItem item = new PayoutItem();
            item.setPayoutBatchId(batch.getId()); // will be populated after save/cascading
            item.setBookingId(booking.getId());
            item.setWasherId(booking.getAssignedWasherId());
            item.setPayoutAmount(amount);
            item.setPayoutStatus(PayoutStatus.PENDING);
            items.add(item);
            
            totalAmount = totalAmount.add(amount);
            jobs++;
        }

        batch.setItems(items);
        batch.setTotalAmount(totalAmount);
        batch.setTotalJobs(jobs);

        for (PayoutItem item : items) {
            item.setPayoutBatchId(batch.getId()); // Will be updated correctly by JPA if we set it after save, but we need cascade
        }
        
        PayoutBatch savedBatch = payoutBatchRepository.save(batch);
        
        // Update batch id on items just in case cascade is not bi-directional yet
        for (PayoutItem item : savedBatch.getItems()) {
            item.setPayoutBatchId(savedBatch.getId());
        }
        payoutBatchRepository.save(savedBatch);
        
        return savedBatch.getId();
    }
}
