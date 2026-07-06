package com.company.vehiclewash.booking.calculateprice;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/bookings")
public class CalculatePriceController {

    private final CalculatePriceService calculatePriceService;

    public CalculatePriceController(CalculatePriceService calculatePriceService) {
        this.calculatePriceService = calculatePriceService;
    }

    @PostMapping("/calculate-price")
    public ResponseEntity<ApiResponse<CalculatePriceResponse>> calculatePrice(@Valid @RequestBody CalculatePriceRequest request) {
        CalculatePriceResponse response = calculatePriceService.calculatePrice(request);
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
