package com.company.vehiclewash.reporting.disputes;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/admin/reports")
public class DisputesReportController {

    private final DisputesReportService disputesReportService;

    public DisputesReportController(DisputesReportService disputesReportService) {
        this.disputesReportService = disputesReportService;
    }

    @GetMapping("/disputes")
    @PreAuthorize("hasRole('ADMIN')")
    public ApiResponse<Map<String, Object>> getDisputes(
            @RequestParam("startDate") LocalDate startDate,
            @RequestParam("endDate") LocalDate endDate) {
        return ApiResponse.success(disputesReportService.getDisputesReport(startDate, endDate));
    }
}
