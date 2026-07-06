package com.company.vehiclewash.auth.requestOtp;

public class RequestOtpResponse {
    private int otpExpiresInSeconds;

    public RequestOtpResponse(int otpExpiresInSeconds) {
        this.otpExpiresInSeconds = otpExpiresInSeconds;
    }

    public int getOtpExpiresInSeconds() {
        return otpExpiresInSeconds;
    }

    public void setOtpExpiresInSeconds(int otpExpiresInSeconds) {
        this.otpExpiresInSeconds = otpExpiresInSeconds;
    }
}
