package com.company.vehiclewash.dispute.createDispute;

import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.common.exception.ResourceNotFoundException;
import com.company.vehiclewash.dispute.entity.Dispute;
import com.company.vehiclewash.dispute.enums.DisputeStatus;
import com.company.vehiclewash.dispute.enums.RaisedBy;
import com.company.vehiclewash.dispute.repository.DisputeRepository;
import com.company.vehiclewash.security.SecurityUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class CreateDisputeService {

    private final DisputeRepository disputeRepository;
    private final BookingRepository bookingRepository;

    @Transactional
    public void createDispute(UUID bookingId, CreateDisputeRequest request) {
        Booking booking = bookingRepository.findById(bookingId)
                .orElseThrow(() -> new ResourceNotFoundException("Booking not found with ID: " + bookingId));

        if (booking.getBookingStatus() != BookingStatus.COMPLETED) {
            throw new RuntimeException("Cannot raise a dispute for a booking that is not completed.");
        }
        
        if (Boolean.TRUE.equals(booking.getHasDispute())) {
            throw new RuntimeException("Dispute already exists for this booking.");
        }

        // We determine who raised it based on roles for MVP. Let's default to CUSTOMER if not admin.
        RaisedBy raisedBy = SecurityUtils.hasRole("WASHER") ? RaisedBy.WASHER : RaisedBy.CUSTOMER;
        if (SecurityUtils.hasRole("ADMIN")) {
            raisedBy = RaisedBy.ADMIN;
        }

        Dispute dispute = Dispute.builder()
                .bookingId(bookingId)
                .disputeType(request.getType())
                .raisedBy(raisedBy)
                .disputeStatus(DisputeStatus.OPEN)
                .issueDescription(request.getDescription())
                .build();

        disputeRepository.save(dispute);

        booking.setHasDispute(true);
        booking.setBookingStatus(BookingStatus.DISPUTED);
        bookingRepository.save(booking);

        log.info("Dispute created for booking: {}", bookingId);
    }
}
