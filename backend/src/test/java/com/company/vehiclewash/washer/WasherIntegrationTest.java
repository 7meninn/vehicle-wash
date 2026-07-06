package com.company.vehiclewash.washer;

import com.company.vehiclewash.AbstractIntegrationTest;
import com.company.vehiclewash.washer.availability.SlotAvailabilityRequest;
import com.company.vehiclewash.washer.availability.UpdateAvailabilityRequest;
import com.company.vehiclewash.washer.enums.WasherVehicleType;
import com.company.vehiclewash.washer.register.RegisterWasherRequest;
import com.company.vehiclewash.washer.entity.ServiceArea;
import com.company.vehiclewash.washer.repository.ServiceAreaRepository;
import com.company.vehiclewash.washer.servicearea.UpdateServiceAreasRequest;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class WasherIntegrationTest extends AbstractIntegrationTest {

    @Autowired
    private ServiceAreaRepository serviceAreaRepository;

    @Test
    public void testWasherOnboardingAndOperations() throws Exception {
        String washerMobile = "9998887776";
        String token = getWasherToken(washerMobile);

        // 1. Register Washer
        RegisterWasherRequest registerReq = new RegisterWasherRequest();
        registerReq.setFullName("Test Washer");
        registerReq.setMobileNumber(washerMobile);
        registerReq.setVehicleType(WasherVehicleType.TWO_WHEELER);
        registerReq.setHomeAddress("123 Test St");
        registerReq.setLatitude(new BigDecimal("28.6139"));
        registerReq.setLongitude(new BigDecimal("77.2090"));

        mockMvc.perform(post("/api/v1/washers/me/register")
                .header("Authorization", token)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(registerReq)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true));

        // 2. Get Profile
        mockMvc.perform(get("/api/v1/washers/me")
                .header("Authorization", token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.fullName").value("Test Washer"))
                .andExpect(jsonPath("$.data.trustScore").value(100.0))
                .andExpect(jsonPath("$.data.totalCompletedJobs").value(0));

        // 3. Update Availability (Slice 5)
        UpdateAvailabilityRequest availReq = new UpdateAvailabilityRequest();
        availReq.setDate(LocalDate.now().plusDays(5));
        SlotAvailabilityRequest slotReq = new SlotAvailabilityRequest();
        slotReq.setSlotId(UUID.randomUUID());
        slotReq.setAvailable(true);
        availReq.setSlots(List.of(slotReq));

        mockMvc.perform(put("/api/v1/washers/me/availability")
                .header("Authorization", token)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(availReq)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        // Test constraint: over 30 days
        UpdateAvailabilityRequest badAvailReq = new UpdateAvailabilityRequest();
        badAvailReq.setDate(LocalDate.now().plusDays(35));
        badAvailReq.setSlots(List.of(slotReq));

        mockMvc.perform(put("/api/v1/washers/me/availability")
                .header("Authorization", token)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(badAvailReq)))
                .andExpect(status().isBadRequest());

        // 4. Update Service Area (Slice 5)
        ServiceArea area = new ServiceArea();
        area.setName("Downtown");
        area.setPolygonGeojson("{}");
        area.setActive(true);
        area = serviceAreaRepository.save(area);

        UpdateServiceAreasRequest saReq = new UpdateServiceAreasRequest();
        saReq.setServiceAreaIds(List.of(area.getId()));

        mockMvc.perform(put("/api/v1/washers/me/service-areas")
                .header("Authorization", token)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(saReq)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }
}
