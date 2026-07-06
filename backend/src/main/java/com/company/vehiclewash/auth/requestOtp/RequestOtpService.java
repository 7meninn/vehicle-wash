package com.company.vehiclewash.auth.requestOtp;

import com.company.vehiclewash.auth.entity.Otp;
import com.company.vehiclewash.auth.repository.OtpRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.temporal.ChronoUnit;

@Service
public class RequestOtpService {

    private static final Logger log = LoggerFactory.getLogger(RequestOtpService.class);
    private final OtpRepository otpRepository;
    private static final int OTP_EXPIRY_SECONDS = 300;

    public RequestOtpService(OtpRepository otpRepository) {
        this.otpRepository = otpRepository;
    }

    @Transactional
    public RequestOtpResponse requestOtp(RequestOtpRequest request) {
        // Here we could implement rate limiting if needed
        String mobileNumber = request.getMobileNumber();

        // Generate OTP
        String otpCode = "123456"; // Hardcoded for development as requested

        Otp otp = new Otp();
        otp.setMobileNumber(mobileNumber);
        otp.setOtpCode(otpCode);
        otp.setExpiresAt(Instant.now().plus(OTP_EXPIRY_SECONDS, ChronoUnit.SECONDS));

        otpRepository.save(otp);

        log.info("Generated OTP {} for mobile number {}", otpCode, mobileNumber);

        return new RequestOtpResponse(OTP_EXPIRY_SECONDS);
    }
}
