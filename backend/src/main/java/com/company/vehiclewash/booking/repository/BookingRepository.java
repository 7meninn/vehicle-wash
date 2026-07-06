package com.company.vehiclewash.booking.repository;

import com.company.vehiclewash.booking.entity.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;

public interface BookingRepository extends JpaRepository<Booking, UUID> {
}
