package com.company.vehiclewash.media.repository;

import com.company.vehiclewash.media.entity.Media;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;

public interface MediaRepository extends JpaRepository<Media, UUID> {
    List<Media> findByBookingId(UUID bookingId);
}
