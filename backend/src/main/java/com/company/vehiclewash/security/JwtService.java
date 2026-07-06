package com.company.vehiclewash.security;

import com.company.vehiclewash.auth.entity.Role;
import com.company.vehiclewash.auth.entity.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class JwtService {

    private final SecretKey key;
    private final long accessExpirationSeconds;
    private final long refreshExpirationSeconds;

    public JwtService(
            @Value("${jwt.secret:defaultSecretKeyThatIsAtLeast32BytesLongForHS256Algorithm}") String secret,
            @Value("${jwt.access.expiration:1800}") long accessExpirationSeconds,
            @Value("${jwt.refresh.expiration:604800}") long refreshExpirationSeconds) {
        this.key = Keys.hmacShaKeyFor(secret.getBytes());
        this.accessExpirationSeconds = accessExpirationSeconds;
        this.refreshExpirationSeconds = refreshExpirationSeconds;
    }

    public String generateAccessToken(User user) {
        return buildToken(user, accessExpirationSeconds);
    }

    public String generateRefreshToken(User user) {
        return buildToken(user, refreshExpirationSeconds);
    }

    private String buildToken(User user, long expirationSeconds) {
        Instant now = Instant.now();
        Instant expiry = now.plus(expirationSeconds, ChronoUnit.SECONDS);

        List<String> roles = user.getRoles().stream()
                .map(Role::name)
                .collect(Collectors.toList());

        return Jwts.builder()
                .subject(user.getMobileNumber())
                .claim("userId", user.getId().toString())
                .claim("roles", roles)
                .issuedAt(Date.from(now))
                .expiration(Date.from(expiry))
                .signWith(key)
                .compact();
    }
    
    public long getAccessExpirationSeconds() {
        return accessExpirationSeconds;
    }

    public Claims extractAllClaims(String token) {
        return Jwts.parser()
                .verifyWith(key)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    public String extractMobileNumber(String token) {
        return extractAllClaims(token).getSubject();
    }

    public boolean isTokenValid(String token) {
        try {
            return extractAllClaims(token).getExpiration().after(new Date());
        } catch (Exception e) {
            return false;
        }
    }
}
