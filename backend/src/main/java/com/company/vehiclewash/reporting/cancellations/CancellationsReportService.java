package com.company.vehiclewash.reporting.cancellations;

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
public class CancellationsReportService {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    public Map<String, Object> getCancellationsReport(LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT cancellation_by, COUNT(id) " +
                     "FROM bookings " +
                     "WHERE booking_status = 'CANCELLED' " +
                     "AND cancelled_at >= :startDate AND cancelled_at < :endDate " +
                     "GROUP BY cancellation_by";

        Query query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate.atStartOfDay().toInstant(ZoneOffset.UTC));
        query.setParameter("endDate", endDate.plusDays(1).atStartOfDay().toInstant(ZoneOffset.UTC));

        List<Object[]> results = query.getResultList();
        
        Map<String, Object> byInitiator = new HashMap<>();
        long totalCancellations = 0;
        
        for (Object[] row : results) {
            String initiator = (String) row[0];
            if (initiator == null) initiator = "UNKNOWN";
            Number count = (Number) row[1];
            byInitiator.put(initiator, count.longValue());
            totalCancellations += count.longValue();
        }

        Map<String, Object> report = new HashMap<>();
        report.put("totalCancellations", totalCancellations);
        report.put("byInitiator", byInitiator);
        return report;
    }
}
