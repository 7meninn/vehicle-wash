package com.company.vehiclewash.reporting.washers;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.HashMap;
import java.util.Map;

@Service
public class WashersReportService {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    public Map<String, Object> getWashersReport(LocalDate startDate, LocalDate endDate) {
        // Active washers
        String activeSql = "SELECT COUNT(id) FROM washers WHERE is_active = true";
        Number activeWashers = (Number) entityManager.createNativeQuery(activeSql).getSingleResult();
        
        // New washers in period
        String newSql = "SELECT COUNT(id) FROM washers WHERE created_at >= :startDate AND created_at < :endDate";
        Query newQuery = entityManager.createNativeQuery(newSql);
        newQuery.setParameter("startDate", startDate.atStartOfDay().toInstant(ZoneOffset.UTC));
        newQuery.setParameter("endDate", endDate.plusDays(1).atStartOfDay().toInstant(ZoneOffset.UTC));
        Number newWashers = (Number) newQuery.getSingleResult();

        Map<String, Object> report = new HashMap<>();
        report.put("activeWashers", activeWashers.longValue());
        report.put("newWashers", newWashers.longValue());
        return report;
    }
}
