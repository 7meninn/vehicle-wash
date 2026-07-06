package com.company.vehiclewash.booking.execution;

import com.company.vehiclewash.AbstractIntegrationTest;
import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class ExecutionServiceIntegrationTest extends AbstractIntegrationTest {

    @Autowired
    private ExecutionService executionService;

    @Autowired
    private BookingRepository bookingRepository;

    private UUID bookingId;

    @BeforeEach
    void setUp() {
        Booking booking = new Booking();
        // Use the mock UUID from SecurityUtils
        booking.setAssignedWasherId(UUID.fromString("11111111-1111-1111-1111-111111111111"));
        booking.setBookingStatus(BookingStatus.ASSIGNED);
        booking = bookingRepository.save(booking);
        bookingId = booking.getId();
    }

    @AfterEach
    void tearDown() {
        bookingRepository.deleteAll();
    }

    @Test
    void testStateTransitions() {
        // ASSIGNED -> ON_THE_WAY
        UpdateBookingStatusRequest req1 = new UpdateBookingStatusRequest();
        req1.setStatus("ON_THE_WAY");
        executionService.updateBookingStatus(bookingId, req1);
        
        Booking b1 = bookingRepository.findById(bookingId).orElseThrow();
        assertThat(b1.getBookingStatus()).isEqualTo(BookingStatus.ON_THE_WAY);

        // ON_THE_WAY -> WASH_STARTED
        UpdateBookingStatusRequest req2 = new UpdateBookingStatusRequest();
        req2.setStatus("WASH_STARTED");
        executionService.updateBookingStatus(bookingId, req2);
        
        Booking b2 = bookingRepository.findById(bookingId).orElseThrow();
        assertThat(b2.getBookingStatus()).isEqualTo(BookingStatus.WASH_STARTED);
        assertThat(b2.getWashStartedAt()).isNotNull();

        // WASH_STARTED -> COMPLETED
        UpdateBookingStatusRequest req3 = new UpdateBookingStatusRequest();
        req3.setStatus("COMPLETED");
        executionService.updateBookingStatus(bookingId, req3);
        
        Booking b3 = bookingRepository.findById(bookingId).orElseThrow();
        assertThat(b3.getBookingStatus()).isEqualTo(BookingStatus.COMPLETED);
        assertThat(b3.getCompletedAt()).isNotNull();
    }

    @Test
    void testInvalidTransitionThrowsException() {
        // Currently in ASSIGNED state, try to jump to COMPLETED
        UpdateBookingStatusRequest req = new UpdateBookingStatusRequest();
        req.setStatus("COMPLETED");
        
        Exception exception = assertThrows(RuntimeException.class, () -> {
            executionService.updateBookingStatus(bookingId, req);
        });
        
        assertThat(exception.getMessage()).contains("Can only transition to COMPLETED from WASH_STARTED state");
    }
}
