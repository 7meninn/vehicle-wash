package com.company.vehiclewash.booking.execution;

import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.UUID;

@Service
public class ExecutionService {

    private final BookingRepository bookingRepository;

    public ExecutionService(BookingRepository bookingRepository) {
        this.bookingRepository = bookingRepository;
    }

    @Transactional
    public void updateBookingStatus(UUID bookingId, UpdateBookingStatusRequest request) {
        UUID washerId = SecurityUtils.getCurrentWasherId();
        
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        if (!washerId.equals(booking.getAssignedWasherId())) {
            throw new RuntimeException("Unauthorized: Not assigned to this booking");
        }

        BookingStatus requestedStatus;
        try {
            requestedStatus = BookingStatus.valueOf(request.getStatus().toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid status provided");
        }

        // Validate FSM transitions
        BookingStatus currentStatus = booking.getBookingStatus();

        if (requestedStatus == BookingStatus.ON_THE_WAY) {
            if (currentStatus != BookingStatus.ASSIGNED) {
                throw new RuntimeException("Can only transition to ON_THE_WAY from ASSIGNED state");
            }
        } else if (requestedStatus == BookingStatus.WASH_STARTED) {
            if (currentStatus != BookingStatus.ON_THE_WAY) {
                throw new RuntimeException("Can only transition to WASH_STARTED from ON_THE_WAY state");
            }
            booking.setWashStartedAt(Instant.now());
        } else if (requestedStatus == BookingStatus.COMPLETED) {
            if (currentStatus != BookingStatus.WASH_STARTED) {
                throw new RuntimeException("Can only transition to COMPLETED from WASH_STARTED state");
            }
            booking.setCompletedAt(Instant.now());
        } else {
            throw new RuntimeException("Invalid state transition requested via this API");
        }

        booking.setBookingStatus(requestedStatus);
        bookingRepository.save(booking);
    }
}
