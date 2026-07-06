package com.company.vehiclewash.customer.getAddresses;

import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/customers")
public class GetAddressesController {

    private final GetAddressesService getAddressesService;

    public GetAddressesController(GetAddressesService getAddressesService) {
        this.getAddressesService = getAddressesService;
    }

    @GetMapping("/me/addresses")
    public ResponseEntity<ApiResponse<List<AddressResponse>>> getAddresses() {
        List<AddressResponse> response = getAddressesService.getAddresses();
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
