package com.company.vehiclewash.washer.servicearea;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/washers")
public class WasherServiceAreaController {

    private final WasherServiceAreaService washerServiceAreaService;

    public WasherServiceAreaController(WasherServiceAreaService washerServiceAreaService) {
        this.washerServiceAreaService = washerServiceAreaService;
    }

    @GetMapping("/me/service-areas")
    public ResponseEntity<ApiResponse<List<ServiceAreaResponse>>> getServiceAreas() {
        List<ServiceAreaResponse> response = washerServiceAreaService.getServiceAreas();
        return ResponseEntity.ok(ApiResponse.success(response));
    }

    @PutMapping("/me/service-areas")
    public ResponseEntity<ApiResponse<Void>> updateServiceAreas(@Valid @RequestBody UpdateServiceAreasRequest request) {
        washerServiceAreaService.updateServiceAreas(request);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
