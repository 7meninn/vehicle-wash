package com.company.vehiclewash.reporting.cancellations;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/admin/reports")
public class CancellationsReportController {

    private final CancellationsReportService cancellationsReportService;

    public CancellationsReportController(CancellationsReportService cancellationsReportService) {
        this.cancellationsReportService = cancellationsReportService;
    }

    @GetMapping("/cancellations")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<Map<String, Object>> getCancellations(
            @RequestParam("startDate") LocalDate startDate,
            @RequestParam("endDate") LocalDate endDate) {
        return ApiResponse.success(cancellationsReportService.getCancellationsReport(startDate, endDate));
    }
}
