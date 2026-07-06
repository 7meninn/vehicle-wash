package com.company.vehiclewash.customer.repository;

import com.company.vehiclewash.customer.entity.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;

public interface VehicleRepository extends JpaRepository<Vehicle, UUID> {
    List<Vehicle> findByCustomerId(UUID customerId);
    boolean existsByCustomerIdAndVehicleNumber(UUID customerId, String vehicleNumber);
}
