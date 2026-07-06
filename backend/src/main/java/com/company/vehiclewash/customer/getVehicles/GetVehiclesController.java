package com.company.vehiclewash.customer.getVehicles;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/customers")
public class GetVehiclesController {

    private final GetVehiclesService getVehiclesService;

    public GetVehiclesController(GetVehiclesService getVehiclesService) {
        this.getVehiclesService = getVehiclesService;
    }

    @GetMapping("/me/vehicles")
    public ResponseEntity<ApiResponse<List<VehicleResponse>>> getVehicles() {
        List<VehicleResponse> response = getVehiclesService.getVehicles();
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
