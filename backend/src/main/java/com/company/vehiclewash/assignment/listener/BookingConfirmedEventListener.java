package com.company.vehiclewash.assignment.listener;

import com.company.vehiclewash.assignment.entity.Assignment;
import com.company.vehiclewash.assignment.entity.AssignmentRequest;
import com.company.vehiclewash.assignment.enums.AssignmentStatus;
import com.company.vehiclewash.assignment.repository.AssignmentRepository;
import com.company.vehiclewash.assignment.repository.AssignmentRequestRepository;
import com.company.vehiclewash.booking.event.BookingConfirmedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.UUID;

@Component
public class BookingConfirmedEventListener {

    private final AssignmentRepository assignmentRepository;
    private final AssignmentRequestRepository assignmentRequestRepository;

    public BookingConfirmedEventListener(
            AssignmentRepository assignmentRepository,
            AssignmentRequestRepository assignmentRequestRepository) {
        this.assignmentRepository = assignmentRepository;
        this.assignmentRequestRepository = assignmentRequestRepository;
    }

    @EventListener
    @Transactional
    public void handleBookingConfirmed(BookingConfirmedEvent event) {
        // Logic to find an eligible washer.
        // Mocking the geospatial search by returning a dummy washer ID.
        UUID eligibleWasherId = UUID.fromString("11111111-1111-1111-1111-111111111111");

        // Create assignment (booking_assignments)
        Assignment assignment = new Assignment();
        assignment.setBookingId(event.getBookingId());
        assignment.setWasherId(eligibleWasherId);
        assignment.setAssignmentStatus(AssignmentStatus.SENT);
        assignmentRepository.save(assignment);

        // Record the attempt (assignment_attempts)
        AssignmentRequest attempt = new AssignmentRequest();
        attempt.setBookingId(event.getBookingId());
        attempt.setWasherId(eligibleWasherId);
        attempt.setRankScore(new BigDecimal("99.9"));
        assignmentRequestRepository.save(attempt);
        
        // At this point, the washer could be notified via WebSockets/FCM in a real app.
    }
}
