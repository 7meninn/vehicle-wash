package com.company.vehiclewash.reporting.bookings;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BookingsReportService {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    public Map<String, Object> getBookingsReport(LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT booking_status, COUNT(id) " +
                     "FROM bookings " +
                     "WHERE created_at >= :startDate AND created_at < :endDate " +
                     "GROUP BY booking_status";

        Query query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate.atStartOfDay().toInstant(ZoneOffset.UTC));
        query.setParameter("endDate", endDate.plusDays(1).atStartOfDay().toInstant(ZoneOffset.UTC));

        List<Object[]> results = query.getResultList();
        
        Map<String, Object> statusCounts = new HashMap<>();
        long totalBookings = 0;
        
        for (Object[] row : results) {
            String status = (String) row[0];
            Number count = (Number) row[1];
            statusCounts.put(status, count.longValue());
            totalBookings += count.longValue();
        }

        Map<String, Object> report = new HashMap<>();
        report.put("totalBookings", totalBookings);
        report.put("statusCounts", statusCounts);
        return report;
    }
}
