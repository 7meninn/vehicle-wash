package com.company.vehiclewash.washer.availability;

import com.company.vehiclewash.security.SecurityUtils;
import com.company.vehiclewash.washer.entity.WasherAvailability;
import com.company.vehiclewash.washer.repository.WasherAvailabilityRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class WasherAvailabilityService {

    private final WasherAvailabilityRepository availabilityRepository;

    public WasherAvailabilityService(WasherAvailabilityRepository availabilityRepository) {
        this.availabilityRepository = availabilityRepository;
    }

    @Transactional(readOnly = true)
    public List<WasherAvailabilityResponse> getAvailability(LocalDate fromDate, LocalDate toDate) {
        UUID washerId = SecurityUtils.getCurrentWasherId();
        
        return availabilityRepository.findByWasherIdAndSlotDateBetween(washerId, fromDate, toDate)
                .stream()
                .map(a -> {
                    WasherAvailabilityResponse r = new WasherAvailabilityResponse();
                    r.setSlotDate(a.getSlotDate());
                    r.setSlotId(a.getSlotId());
                    r.setAvailable(a.getAvailable());
                    return r;
                })
                .collect(Collectors.toList());
    }

    @Transactional
    public void updateAvailability(UpdateAvailabilityRequest request) {
        UUID washerId = SecurityUtils.getCurrentWasherId();
        LocalDate today = LocalDate.now();

        if (request.getDate().isBefore(today)) {
            throw new org.springframework.web.server.ResponseStatusException(org.springframework.http.HttpStatus.BAD_REQUEST, "Cannot modify availability for past dates");
        }

        if (request.getDate().isAfter(today.plusDays(30))) {
            throw new org.springframework.web.server.ResponseStatusException(org.springframework.http.HttpStatus.BAD_REQUEST, "Maximum future window is 30 Days");
        }

        for (SlotAvailabilityRequest slotRequest : request.getSlots()) {
            Optional<WasherAvailability> existingOpt = availabilityRepository
                    .findByWasherIdAndSlotDateAndSlotId(washerId, request.getDate(), slotRequest.getSlotId());

            if (existingOpt.isPresent()) {
                WasherAvailability existing = existingOpt.get();
                existing.setAvailable(slotRequest.getAvailable());
                availabilityRepository.save(existing);
            } else {
                WasherAvailability newAvail = new WasherAvailability();
                newAvail.setWasherId(washerId);
                newAvail.setSlotDate(request.getDate());
                newAvail.setSlotId(slotRequest.getSlotId());
                newAvail.setAvailable(slotRequest.getAvailable());
                availabilityRepository.save(newAvail);
            }
        }
    }
}
