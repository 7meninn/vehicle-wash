package com.company.vehiclewash.auth.requestOtp;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
public class RequestOtpController {

    private final RequestOtpService requestOtpService;

    public RequestOtpController(RequestOtpService requestOtpService) {
        this.requestOtpService = requestOtpService;
    }

    @PostMapping("/request-otp")
    public ResponseEntity<ApiResponse<RequestOtpResponse>> requestOtp(@Valid @RequestBody RequestOtpRequest request) {
        RequestOtpResponse response = requestOtpService.requestOtp(request);
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
