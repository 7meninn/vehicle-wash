package com.company.vehiclewash.customer.getVehicles;

import com.company.vehiclewash.customer.repository.VehicleRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class GetVehiclesService {

    private final VehicleRepository vehicleRepository;

    public GetVehiclesService(VehicleRepository vehicleRepository) {
        this.vehicleRepository = vehicleRepository;
    }

    @Transactional(readOnly = true)
    public List<VehicleResponse> getVehicles() {
        UUID customerId = SecurityUtils.getCurrentUserId();

        return vehicleRepository.findByCustomerId(customerId).stream()
                .map(vehicle -> {
                    VehicleResponse response = new VehicleResponse();
                    response.setId(vehicle.getId());
                    response.setVehicleType(vehicle.getVehicleType());
                    response.setVehicleNumber(vehicle.getVehicleNumber());
                    response.setVehicleBrand(vehicle.getVehicleBrand());
                    response.setVehicleModel(vehicle.getVehicleModel());
                    response.setVehicleColor(vehicle.getVehicleColor());
                    response.setDefault(vehicle.getDefault());
                    return response;
                })
                .collect(Collectors.toList());
    }
}
