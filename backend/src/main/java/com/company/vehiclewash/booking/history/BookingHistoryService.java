package com.company.vehiclewash.booking.history;

import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.booking.repository.BookingRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.UUID;

@Service
public class BookingHistoryService {

    private final BookingRepository bookingRepository;
    private final com.company.vehiclewash.auth.repository.UserRepository userRepository;
    private final com.company.vehiclewash.customer.repository.CustomerRepository customerRepository;
    private final com.company.vehiclewash.washer.repository.WasherRepository washerRepository;

    public BookingHistoryService(BookingRepository bookingRepository,
                                 com.company.vehiclewash.auth.repository.UserRepository userRepository,
                                 com.company.vehiclewash.customer.repository.CustomerRepository customerRepository,
                                 com.company.vehiclewash.washer.repository.WasherRepository washerRepository) {
        this.bookingRepository = bookingRepository;
        this.userRepository = userRepository;
        this.customerRepository = customerRepository;
        this.washerRepository = washerRepository;
    }

    @Transactional(readOnly = true)
    public Page<BookingHistoryResponse> getCustomerBookings(BookingStatus status, LocalDate fromDate, LocalDate toDate, int page, int size) {
        UUID userId = SecurityUtils.getCurrentUserId();
        com.company.vehiclewash.auth.entity.User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        com.company.vehiclewash.customer.entity.Customer customer = customerRepository.findByMobileNumber(user.getMobileNumber())
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<Booking> bookings = bookingRepository.findCustomerHistory(customer.getId(), status, fromDate, toDate, pageable);
        return bookings.map(this::mapToResponse);
    }

    @Transactional(readOnly = true)
    public Page<BookingHistoryResponse> getWasherBookings(BookingStatus status, LocalDate fromDate, LocalDate toDate, int page, int size) {
        UUID userId = SecurityUtils.getCurrentWasherId();
        com.company.vehiclewash.auth.entity.User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        com.company.vehiclewash.washer.entity.Washer washer = washerRepository.findByMobileNumber(user.getMobileNumber())
                .orElseThrow(() -> new RuntimeException("Washer not found"));

        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));
        Page<Booking> bookings = bookingRepository.findWasherHistory(washer.getId(), status, fromDate, toDate, pageable);
        return bookings.map(this::mapToResponse);
    }

    private BookingHistoryResponse mapToResponse(Booking booking) {
        BookingHistoryResponse response = new BookingHistoryResponse();
        response.setId(booking.getId());
        response.setBookingNumber(booking.getBookingNumber());
        response.setCustomerId(booking.getCustomerId());
        response.setAssignedWasherId(booking.getAssignedWasherId());
        response.setBookingStatus(booking.getBookingStatus());
        response.setBookingDate(booking.getBookingDate());
        response.setScheduledStartTime(booking.getScheduledStartTime());
        response.setScheduledEndTime(booking.getScheduledEndTime());
        response.setPaymentStatus(booking.getPaymentStatus());
        response.setCreatedAt(booking.getCreatedAt());
        return response;
    }
}
