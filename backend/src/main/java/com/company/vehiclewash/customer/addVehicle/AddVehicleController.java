package com.company.vehiclewash.customer.addVehicle;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/customers")
public class AddVehicleController {

    private final AddVehicleService addVehicleService;

    public AddVehicleController(AddVehicleService addVehicleService) {
        this.addVehicleService = addVehicleService;
    }

    @PostMapping("/me/vehicles")
    public ResponseEntity<ApiResponse<Void>> addVehicle(@Valid @RequestBody AddVehicleRequest request) {
        addVehicleService.addVehicle(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }
}
