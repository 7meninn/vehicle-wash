package com.company.vehiclewash.customer.addVehicle;

import com.company.vehiclewash.customer.entity.Vehicle;
import com.company.vehiclewash.customer.repository.VehicleRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class AddVehicleService {

    private final VehicleRepository vehicleRepository;

    public AddVehicleService(VehicleRepository vehicleRepository) {
        this.vehicleRepository = vehicleRepository;
    }

    @Transactional
    public void addVehicle(AddVehicleRequest request) {
        UUID customerId = SecurityUtils.getCurrentUserId();

        if (vehicleRepository.existsByCustomerIdAndVehicleNumber(customerId, request.getVehicleNumber())) {
            throw new RuntimeException("Vehicle number already registered for this customer");
        }

        Vehicle vehicle = new Vehicle();
        vehicle.setCustomerId(customerId);
        vehicle.setVehicleType(request.getVehicleType());
        vehicle.setVehicleNumber(request.getVehicleNumber());
        vehicle.setVehicleBrand(request.getBrand());
        vehicle.setVehicleModel(request.getModel());
        vehicle.setVehicleColor(request.getColor());

        // Set as default if this is the first vehicle
        boolean isFirstVehicle = vehicleRepository.findByCustomerId(customerId).isEmpty();
        vehicle.setDefault(isFirstVehicle);

        vehicleRepository.save(vehicle);
    }
}
