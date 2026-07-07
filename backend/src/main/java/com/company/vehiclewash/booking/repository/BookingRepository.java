package com.company.vehiclewash.booking.repository;

import com.company.vehiclewash.booking.entity.Booking;
import com.company.vehiclewash.booking.enums.BookingStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.UUID;

public interface BookingRepository extends JpaRepository<Booking, UUID> {

    @Query("SELECT b FROM Booking b WHERE b.customerId = :customerId " +
           "AND (:status IS NULL OR b.bookingStatus = :status) " +
           "AND (cast(:fromDate as date) IS NULL OR b.bookingDate >= :fromDate) " +
           "AND (cast(:toDate as date) IS NULL OR b.bookingDate <= :toDate)")
    Page<Booking> findCustomerHistory(
            @Param("customerId") UUID customerId, 
            @Param("status") BookingStatus status,
            @Param("fromDate") LocalDate fromDate, 
            @Param("toDate") LocalDate toDate, 
            Pageable pageable);

    @Query("SELECT b FROM Booking b WHERE b.assignedWasherId = :washerId " +
           "AND (:status IS NULL OR b.bookingStatus = :status) " +
           "AND (cast(:fromDate as date) IS NULL OR b.bookingDate >= :fromDate) " +
           "AND (cast(:toDate as date) IS NULL OR b.bookingDate <= :toDate)")
    Page<Booking> findWasherHistory(
            @Param("washerId") UUID washerId, 
            @Param("status") BookingStatus status,
            @Param("fromDate") LocalDate fromDate, 
            @Param("toDate") LocalDate toDate, 
            Pageable pageable);
}
