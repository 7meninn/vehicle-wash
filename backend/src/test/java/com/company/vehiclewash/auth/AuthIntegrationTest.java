package com.company.vehiclewash.auth;

import com.company.vehiclewash.AbstractIntegrationTest;
import com.company.vehiclewash.auth.requestOtp.RequestOtpRequest;
import com.company.vehiclewash.auth.verifyOtp.VerifyOtpRequest;
import com.company.vehiclewash.auth.repository.OtpRepository;
import com.company.vehiclewash.auth.entity.Otp;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import java.util.List;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class AuthIntegrationTest extends AbstractIntegrationTest {

    @Autowired
    private OtpRepository otpRepository;

    @Test
    public void testOtpRequestAndVerification() throws Exception {
        String mobileNumber = "9876543210";

        // 1. Request OTP
        RequestOtpRequest req = new RequestOtpRequest();
        req.setMobileNumber(mobileNumber);

        mockMvc.perform(post("/api/v1/auth/request-otp")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        // Get the OTP from DB since it's an integration test and we don't have SMS delivery
        List<Otp> otps = otpRepository.findAll();
        Otp generatedOtp = otps.stream()
                .filter(o -> o.getMobileNumber().equals(mobileNumber))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("OTP not found"));

        // 2. Verify OTP
        VerifyOtpRequest verifyReq = new VerifyOtpRequest();
        verifyReq.setMobileNumber(mobileNumber);
        verifyReq.setOtp(generatedOtp.getOtpCode());

        mockMvc.perform(post("/api/v1/auth/verify-otp")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(verifyReq)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.accessToken").exists());
    }
}
