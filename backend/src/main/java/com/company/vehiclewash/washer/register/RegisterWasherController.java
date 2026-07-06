package com.company.vehiclewash.washer.register;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/washers")
public class RegisterWasherController {

    private final RegisterWasherService registerWasherService;

    public RegisterWasherController(RegisterWasherService registerWasherService) {
        this.registerWasherService = registerWasherService;
    }

    @PostMapping("/me/register")
    public ResponseEntity<ApiResponse<Void>> registerWasher(@Valid @RequestBody RegisterWasherRequest request) {
        registerWasherService.registerWasher(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }
}
