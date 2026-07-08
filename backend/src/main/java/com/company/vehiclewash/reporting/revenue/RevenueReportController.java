package com.company.vehiclewash.reporting.revenue;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/admin/reports")
public class RevenueReportController {

    private final RevenueReportService revenueReportService;

    public RevenueReportController(RevenueReportService revenueReportService) {
        this.revenueReportService = revenueReportService;
    }

    @GetMapping("/revenue")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<Map<String, Object>> getRevenue(
            @RequestParam("startDate") LocalDate startDate,
            @RequestParam("endDate") LocalDate endDate) {
        return ApiResponse.success(revenueReportService.getRevenueReport(startDate, endDate));
    }
}
