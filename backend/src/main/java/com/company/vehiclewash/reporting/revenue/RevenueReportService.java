package com.company.vehiclewash.reporting.revenue;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.HashMap;
import java.util.Map;

@Service
public class RevenueReportService {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    public Map<String, Object> getRevenueReport(LocalDate startDate, LocalDate endDate) {
        String sql = "SELECT COUNT(p.id) as totalBookings, SUM(p.amount) as totalRevenue " +
                     "FROM payments p " +
                     "JOIN bookings b ON p.booking_id = b.id " +
                     "WHERE b.booking_status = 'COMPLETED' AND p.payment_status = 'CAPTURED' " +
                     "AND b.completed_at >= :startDate AND b.completed_at < :endDate";

        Query query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate.atStartOfDay().toInstant(ZoneOffset.UTC));
        query.setParameter("endDate", endDate.plusDays(1).atStartOfDay().toInstant(ZoneOffset.UTC));

        Object[] result = (Object[]) query.getSingleResult();
        Number count = result[0] != null ? (Number) result[0] : 0;
        Number revenue = result[1] != null ? (Number) result[1] : 0;
        
        BigDecimal totalRevenue = new BigDecimal(revenue.toString());
        BigDecimal platformFee = totalRevenue.multiply(new BigDecimal("0.20"));
        BigDecimal washerPayout = totalRevenue.multiply(new BigDecimal("0.80"));

        Map<String, Object> report = new HashMap<>();
        report.put("totalCompletedBookings", count.longValue());
        report.put("totalRevenue", totalRevenue);
        report.put("totalPlatformFee", platformFee);
        report.put("totalWasherPayout", washerPayout);
        return report;
    }
}
