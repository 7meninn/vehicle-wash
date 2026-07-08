package com.company.vehiclewash;

import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@ActiveProfiles("test")
@org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
public abstract class AbstractIntegrationTest {
    @org.springframework.beans.factory.annotation.Autowired
    protected org.springframework.test.web.servlet.MockMvc mockMvc;

    @org.junit.jupiter.api.AfterEach
    public void cleanup() {
        com.company.vehiclewash.security.SecurityUtils.clear();
    }

    @org.springframework.beans.factory.annotation.Autowired
    protected com.fasterxml.jackson.databind.ObjectMapper objectMapper;

    public static PostgreSQLContainer<?> postgreSQLContainer = new PostgreSQLContainer<>("postgres:15-alpine")
            .withDatabaseName("vehiclewash_test")
            .withUsername("test")
            .withPassword("test");

    @org.springframework.beans.factory.annotation.Autowired
    protected com.company.vehiclewash.security.JwtService jwtService;

    @org.springframework.beans.factory.annotation.Autowired
    protected com.company.vehiclewash.auth.repository.UserRepository userRepository;

    protected String getCustomerToken(String mobileNumber) {
        com.company.vehiclewash.auth.entity.User user = userRepository.findByMobileNumber(mobileNumber).orElseGet(() -> {
            com.company.vehiclewash.auth.entity.User u = new com.company.vehiclewash.auth.entity.User();
            u.setMobileNumber(mobileNumber);
            u.setRoles(java.util.Set.of(com.company.vehiclewash.auth.entity.Role.CUSTOMER));
            return userRepository.save(u);
        });
        String token = jwtService.generateAccessToken(user);
        com.company.vehiclewash.security.SecurityUtils.setMockUserId(user.getId());
        return "Bearer " + token;
    }

    protected String getWasherToken(String mobileNumber) {
        com.company.vehiclewash.auth.entity.User user = userRepository.findByMobileNumber(mobileNumber).orElseGet(() -> {
            com.company.vehiclewash.auth.entity.User newUser = new com.company.vehiclewash.auth.entity.User();
            newUser.setMobileNumber(mobileNumber);
            newUser.setRoles(java.util.Set.of(com.company.vehiclewash.auth.entity.Role.WASHER));
            return userRepository.save(newUser);
        });
        String token = jwtService.generateAccessToken(user);
        com.company.vehiclewash.security.SecurityUtils.setMockWasherId(user.getId());
        return "Bearer " + token;
    }

    protected String getAdminToken(String mobileNumber) {
        com.company.vehiclewash.auth.entity.User user = userRepository.findByMobileNumber(mobileNumber).orElseGet(() -> {
            com.company.vehiclewash.auth.entity.User newUser = new com.company.vehiclewash.auth.entity.User();
            newUser.setMobileNumber(mobileNumber);
            newUser.setRoles(java.util.Set.of(com.company.vehiclewash.auth.entity.Role.ADMIN));
            return userRepository.save(newUser);
        });
        String token = jwtService.generateAccessToken(user);
        com.company.vehiclewash.security.SecurityUtils.setMockUserId(user.getId());
        return "Bearer " + token;
    }

    static {
        postgreSQLContainer.start();
    }

    @DynamicPropertySource
    static void setProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgreSQLContainer::getJdbcUrl);
        registry.add("spring.datasource.username", postgreSQLContainer::getUsername);
        registry.add("spring.datasource.password", postgreSQLContainer::getPassword);
    }
}
