package com.company.vehiclewash.customer;

import com.company.vehiclewash.AbstractIntegrationTest;
import com.company.vehiclewash.customer.addAddress.AddAddressRequest;
import com.company.vehiclewash.customer.addVehicle.AddVehicleRequest;
import com.company.vehiclewash.customer.enums.VehicleType;
import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;

import java.math.BigDecimal;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class CustomerIntegrationTest extends AbstractIntegrationTest {

    @Test
    public void testCustomerProfileAndVehicles() throws Exception {
        String customerMobile = "9876543211";
        String token = getCustomerToken(customerMobile);

        // 1. Add Vehicle
        AddVehicleRequest vehicleReq = new AddVehicleRequest();
        vehicleReq.setVehicleType(VehicleType.FOUR_WHEELER);
        vehicleReq.setVehicleNumber("MH12AB1234");
        vehicleReq.setBrand("Hyundai");
        vehicleReq.setModel("i20");
        vehicleReq.setColor("Red");

        mockMvc.perform(post("/api/v1/customers/me/vehicles")
                .header("Authorization", token)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(vehicleReq)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true));

        // Get Vehicles
        mockMvc.perform(get("/api/v1/customers/me/vehicles")
                .header("Authorization", token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data[0].vehicleNumber").value("MH12AB1234"));

        // 2. Add Address
        AddAddressRequest addressReq = new AddAddressRequest();
        addressReq.setLabel("Home");
        addressReq.setAddress("456 MG Road");
        addressReq.setLatitude(new BigDecimal("18.5204"));
        addressReq.setLongitude(new BigDecimal("73.8567"));

        mockMvc.perform(post("/api/v1/customers/me/addresses")
                .header("Authorization", token)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(addressReq)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success").value(true));

        // Get Addresses
        mockMvc.perform(get("/api/v1/customers/me/addresses")
                .header("Authorization", token))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data[0].label").value("Home"));
    }
}
