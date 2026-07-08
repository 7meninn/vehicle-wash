package com.company.vehiclewash.reporting.bookings;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/admin/reports")
public class BookingsReportController {

    private final BookingsReportService bookingsReportService;

    public BookingsReportController(BookingsReportService bookingsReportService) {
        this.bookingsReportService = bookingsReportService;
    }

    @GetMapping("/bookings")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<Map<String, Object>> getBookings(
            @RequestParam("startDate") LocalDate startDate,
            @RequestParam("endDate") LocalDate endDate) {
        return ApiResponse.success(bookingsReportService.getBookingsReport(startDate, endDate));
    }
}
