package com.company.vehiclewash.auth.verifyOtp;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
public class VerifyOtpController {

    private final VerifyOtpService verifyOtpService;

    public VerifyOtpController(VerifyOtpService verifyOtpService) {
        this.verifyOtpService = verifyOtpService;
    }

    @PostMapping("/verify-otp")
    public ResponseEntity<ApiResponse<VerifyOtpResponse>> verifyOtp(@Valid @RequestBody VerifyOtpRequest request) {
        VerifyOtpResponse response = verifyOtpService.verifyOtp(request);
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
