package com.company.vehiclewash.reporting.washers;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/admin/reports")
public class WashersReportController {

    private final WashersReportService washersReportService;

    public WashersReportController(WashersReportService washersReportService) {
        this.washersReportService = washersReportService;
    }

    @GetMapping("/washers")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<Map<String, Object>> getWashers(
            @RequestParam("startDate") LocalDate startDate,
            @RequestParam("endDate") LocalDate endDate) {
        return ApiResponse.success(washersReportService.getWashersReport(startDate, endDate));
    }
}
