package com.company.vehiclewash.reporting;

import com.company.vehiclewash.reporting.revenue.RevenueReportService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class RevenueReportServiceTest {

    @Mock
    private EntityManager entityManager;

    @InjectMocks
    private RevenueReportService revenueReportService;

    @Test
    void testGetRevenueReport() {
        Query query = mock(Query.class);
        when(entityManager.createNativeQuery(anyString())).thenReturn(query);
        when(query.setParameter(anyString(), any())).thenReturn(query);
        
        Object[] result = new Object[]{10L, new BigDecimal("1000.00")};
        when(query.getSingleResult()).thenReturn(result);

        Map<String, Object> report = revenueReportService.getRevenueReport(LocalDate.now(), LocalDate.now());

        assertEquals(10L, report.get("totalCompletedBookings"));
        assertEquals(new BigDecimal("1000.00"), report.get("totalRevenue"));
        assertEquals(new BigDecimal("200.0000"), report.get("totalPlatformFee"));
        assertEquals(new BigDecimal("800.0000"), report.get("totalWasherPayout"));
    }
}
