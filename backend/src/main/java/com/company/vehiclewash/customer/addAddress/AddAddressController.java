package com.company.vehiclewash.customer.addAddress;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/customers")
public class AddAddressController {

    private final AddAddressService addAddressService;

    public AddAddressController(AddAddressService addAddressService) {
        this.addAddressService = addAddressService;
    }

    @PostMapping("/me/addresses")
    public ResponseEntity<ApiResponse<Void>> addAddress(@Valid @RequestBody AddAddressRequest request) {
        addAddressService.addAddress(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }
}
