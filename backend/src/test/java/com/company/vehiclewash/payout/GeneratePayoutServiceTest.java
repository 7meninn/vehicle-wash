package com.company.vehiclewash.payout;

import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.payment.entity.Payment;
import com.company.vehiclewash.payment.repository.PaymentRepository;
import com.company.vehiclewash.payout.entity.PayoutBatch;
import com.company.vehiclewash.payout.generate.GeneratePayoutRequest;
import com.company.vehiclewash.payout.generate.GeneratePayoutService;
import com.company.vehiclewash.payout.repository.PayoutBatchRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class GeneratePayoutServiceTest {

    @Mock
    private PayoutBatchRepository payoutBatchRepository;
    
    @Mock
    private BookingRepository bookingRepository;
    
    @Mock
    private PaymentRepository paymentRepository;

    @InjectMocks
    private GeneratePayoutService generatePayoutService;

    @Test
    void testGeneratePayout() {
        LocalDate startDate = LocalDate.now().minusDays(7);
        LocalDate endDate = LocalDate.now();

        GeneratePayoutRequest request = new GeneratePayoutRequest();
        request.setStartDate(startDate);
        request.setEndDate(endDate);

        Booking booking = new Booking();
        booking.setId(UUID.randomUUID());
        booking.setAssignedWasherId(UUID.randomUUID());

        Payment payment = new Payment();
        payment.setId(UUID.randomUUID());
        payment.setAmount(new BigDecimal("1000.00"));
        
        when(bookingRepository.findByBookingStatusAndCompletedAtBetween(eq(BookingStatus.COMPLETED), any(), any()))
                .thenReturn(List.of(booking));
                
        when(paymentRepository.findByBookingId(booking.getId())).thenReturn(Optional.of(payment));

        PayoutBatch savedBatch = new PayoutBatch();
        savedBatch.setId(UUID.randomUUID());
        savedBatch.setItems(List.of());

        when(payoutBatchRepository.save(any(PayoutBatch.class))).thenReturn(savedBatch);

        UUID batchId = generatePayoutService.generatePayout(request);

        assertNotNull(batchId);
        
        ArgumentCaptor<PayoutBatch> batchCaptor = ArgumentCaptor.forClass(PayoutBatch.class);
        verify(payoutBatchRepository, times(2)).save(batchCaptor.capture());
        
        PayoutBatch captured = batchCaptor.getAllValues().get(0);
        assertEquals(1, captured.getTotalJobs());
        assertEquals(new BigDecimal("800.00"), captured.getTotalAmount());
        assertEquals(1, captured.getItems().size());
    }
}
