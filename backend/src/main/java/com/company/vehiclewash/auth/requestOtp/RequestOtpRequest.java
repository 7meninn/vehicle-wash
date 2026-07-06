package com.company.vehiclewash.auth.requestOtp;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public class RequestOtpRequest {

    @NotBlank(message = "Mobile number is required")
    @Pattern(regexp = "^[0-9]{10}$", message = "Must be a valid 10-digit mobile number")
    private String mobileNumber;

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }
}
