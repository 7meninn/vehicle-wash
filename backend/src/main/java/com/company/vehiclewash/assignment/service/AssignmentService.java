package com.company.vehiclewash.assignment.service;

import com.company.vehiclewash.assignment.dto.AssignmentResponseDTO;
import com.company.vehiclewash.assignment.entity.Assignment;
import com.company.vehiclewash.assignment.entity.AssignmentRequest;
import com.company.vehiclewash.assignment.enums.AssignmentResponse;
import com.company.vehiclewash.assignment.enums.AssignmentStatus;
import com.company.vehiclewash.assignment.repository.AssignmentRepository;
import com.company.vehiclewash.assignment.repository.AssignmentRequestRepository;
import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class AssignmentService {

    private final AssignmentRepository assignmentRepository;
    private final AssignmentRequestRepository assignmentRequestRepository;
    private final BookingRepository bookingRepository;

    public AssignmentService(
            AssignmentRepository assignmentRepository,
            AssignmentRequestRepository assignmentRequestRepository,
            BookingRepository bookingRepository) {
        this.assignmentRepository = assignmentRepository;
        this.assignmentRequestRepository = assignmentRequestRepository;
        this.bookingRepository = bookingRepository;
    }

    @Transactional(readOnly = true)
    public List<AssignmentResponseDTO> getIncomingRequests() {
        UUID washerId = SecurityUtils.getCurrentWasherId();
        
        return assignmentRepository.findByWasherId(washerId).stream()
                .filter(a -> a.getAssignmentStatus() == AssignmentStatus.SENT)
                .map(a -> {
                    AssignmentResponseDTO dto = new AssignmentResponseDTO();
                    dto.setId(a.getId());
                    dto.setBookingId(a.getBookingId());
                    dto.setAssignmentStatus(a.getAssignmentStatus().name());
                    dto.setAssignedAt(a.getAssignedAt());
                    return dto;
                })
                .collect(Collectors.toList());
    }

    @Transactional
    public void acceptAssignment(UUID assignmentId) {
        processAssignmentResponse(assignmentId, true);
    }

    @Transactional
    public void rejectAssignment(UUID assignmentId) {
        processAssignmentResponse(assignmentId, false);
    }

    private void processAssignmentResponse(UUID assignmentId, boolean accepted) {
        UUID washerId = SecurityUtils.getCurrentWasherId();

        Assignment assignment = assignmentRepository.findById(assignmentId)
                .orElseThrow(() -> new RuntimeException("Assignment not found"));

        if (!assignment.getWasherId().equals(washerId)) {
            throw new RuntimeException("Unauthorized");
        }

        if (assignment.getAssignmentStatus() != AssignmentStatus.SENT) {
            throw new RuntimeException("Assignment is no longer valid");
        }

        if (accepted) {
            assignment.setAssignmentStatus(AssignmentStatus.ACCEPTED);
            assignment.setAcceptedAt(Instant.now());
            assignmentRepository.save(assignment);

            // Update Booking status
            Booking booking = bookingRepository.findById(assignment.getBookingId())
                    .orElseThrow(() -> new RuntimeException("Booking not found"));
            booking.setAssignedWasherId(washerId);
            booking.setBookingStatus(BookingStatus.ASSIGNED);
            bookingRepository.save(booking);

            // Update Attempt log
            updateAttemptLog(assignment.getBookingId(), washerId, AssignmentResponse.ACCEPTED);
        } else {
            assignment.setAssignmentStatus(AssignmentStatus.DECLINED);
            assignment.setRejectedAt(Instant.now());
            assignmentRepository.save(assignment);

            // Update Attempt log
            updateAttemptLog(assignment.getBookingId(), washerId, AssignmentResponse.REJECTED);
            
            // In a real app, we'd trigger a new assignment search here.
        }
    }

    private void updateAttemptLog(UUID bookingId, UUID washerId, AssignmentResponse response) {
        // Ideally we fetch the specific attempt, but for simplicity we log a new one or update
        AssignmentRequest attempt = new AssignmentRequest();
        attempt.setBookingId(bookingId);
        attempt.setWasherId(washerId);
        attempt.setResponse(response);
        attempt.setResponseTimeSeconds(5); // mock 5 seconds
        assignmentRequestRepository.save(attempt);
    }
}
