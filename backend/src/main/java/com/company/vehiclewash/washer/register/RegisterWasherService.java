package com.company.vehiclewash.washer.register;

import com.company.vehiclewash.washer.entity.Washer;
import com.company.vehiclewash.washer.enums.VerificationStatus;
import com.company.vehiclewash.washer.repository.WasherRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RegisterWasherService {

    private final WasherRepository washerRepository;

    public RegisterWasherService(WasherRepository washerRepository) {
        this.washerRepository = washerRepository;
    }

    @Transactional
    public void registerWasher(RegisterWasherRequest request) {
        // Validation could be added to check if washer already exists.
        if (washerRepository.findByMobileNumber(request.getMobileNumber()).isPresent()) {
            throw new RuntimeException("Washer already registered with this mobile number"); // custom exception should be used
        }

        Washer washer = new Washer();
        washer.setFullName(request.getFullName());
        washer.setMobileNumber(request.getMobileNumber());
        washer.setVehicleType(request.getVehicleType());
        washer.setHomeAddress(request.getHomeAddress());
        washer.setHomeLatitude(request.getLatitude());
        washer.setHomeLongitude(request.getLongitude());
        washer.setVerificationStatus(VerificationStatus.PENDING_VERIFICATION);
        washer.setActive(true);

        washerRepository.save(washer);
    }
}
