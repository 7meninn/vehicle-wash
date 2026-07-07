package com.company.vehiclewash.booking.history;

import com.company.vehiclewash.booking.enums.BookingStatus;
import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@RestController
@RequestMapping("/api/v1/bookings")
public class CustomerBookingHistoryController {

    private final BookingHistoryService bookingHistoryService;

    public CustomerBookingHistoryController(BookingHistoryService bookingHistoryService) {
        this.bookingHistoryService = bookingHistoryService;
    }

    @GetMapping
    @PreAuthorize("hasRole('CUSTOMER')")
    public ResponseEntity<ApiResponse<Page<BookingHistoryResponse>>> getMyBookings(
            @RequestParam(required = false) BookingStatus status,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        Page<BookingHistoryResponse> history = bookingHistoryService.getCustomerBookings(status, fromDate, toDate, page, size);
        return ResponseEntity.ok(ApiResponse.success(history));
    }
}
