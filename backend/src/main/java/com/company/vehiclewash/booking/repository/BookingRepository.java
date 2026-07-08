package com.company.vehiclewash.booking.repository;

import com.company.vehiclewash.booking.entity.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface BookingRepository extends JpaRepository<Booking, UUID> {
    java.util.List<Booking> findByBookingStatusAndCompletedAtBetween(com.company.vehiclewash.booking.enums.BookingStatus status, java.time.Instant start, java.time.Instant end);
}
