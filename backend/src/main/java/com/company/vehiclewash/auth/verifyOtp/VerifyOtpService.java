package com.company.vehiclewash.auth.verifyOtp;

import com.company.vehiclewash.auth.entity.Otp;
import com.company.vehiclewash.auth.entity.Role;
import com.company.vehiclewash.auth.entity.User;
import com.company.vehiclewash.auth.repository.OtpRepository;
import com.company.vehiclewash.auth.repository.UserRepository;
import com.company.vehiclewash.security.JwtService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class VerifyOtpService {

    private final OtpRepository otpRepository;
    private final UserRepository userRepository;
    private final JwtService jwtService;

    public VerifyOtpService(OtpRepository otpRepository, UserRepository userRepository, JwtService jwtService) {
        this.otpRepository = otpRepository;
        this.userRepository = userRepository;
        this.jwtService = jwtService;
    }

    @Transactional
    public VerifyOtpResponse verifyOtp(VerifyOtpRequest request) {
        String mobileNumber = request.getMobileNumber();
        String otpCode = request.getOtp();

        Optional<Otp> otpOptional = otpRepository.findTopByMobileNumberOrderByCreatedAtDesc(mobileNumber);

        if (otpOptional.isEmpty()) {
            throw new RuntimeException("Invalid OTP"); // Should be a custom Exception per LLD
        }

        Otp otp = otpOptional.get();

        if (!otp.getOtpCode().equals(otpCode)) {
            throw new RuntimeException("Invalid OTP");
        }

        if (otp.getExpiresAt().isBefore(Instant.now())) {
            throw new RuntimeException("OTP Expired");
        }

        // OTP is valid. Find or create user.
        User user = userRepository.findByMobileNumber(mobileNumber).orElseGet(() -> {
            User newUser = new User();
            newUser.setMobileNumber(mobileNumber);
            newUser.setRoles(Set.of(Role.CUSTOMER)); // Default role
            newUser.setActive(true);
            return userRepository.save(newUser);
        });

        if (!user.getActive()) {
            throw new RuntimeException("User Blocked");
        }

        String accessToken = jwtService.generateAccessToken(user);
        String refreshToken = jwtService.generateRefreshToken(user);

        Set<String> roleStrings = user.getRoles().stream()
                .map(Role::name)
                .collect(Collectors.toSet());

        return new VerifyOtpResponse(
                accessToken,
                refreshToken,
                jwtService.getAccessExpirationSeconds(),
                roleStrings
        );
    }
}
