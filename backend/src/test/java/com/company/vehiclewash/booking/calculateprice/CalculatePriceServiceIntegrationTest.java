package com.company.vehiclewash.booking.calculateprice;

import com.company.vehiclewash.AbstractIntegrationTest;
import com.company.vehiclewash.platform.entity.PlatformConfiguration;
import com.company.vehiclewash.platform.repository.PlatformConfigurationRepository;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;

import static org.assertj.core.api.Assertions.assertThat;

public class CalculatePriceServiceIntegrationTest extends AbstractIntegrationTest {

    @Autowired
    private CalculatePriceService calculatePriceService;

    @Autowired
    private PlatformConfigurationRepository configRepository;

    @BeforeEach
    void setUp() {
        // Setup mock configs
        PlatformConfiguration basePriceConfig = new PlatformConfiguration();
        basePriceConfig.setConfigKey("PRICING_BASE_PRICE");
        basePriceConfig.setConfigValue("250.00");
        basePriceConfig.setDataType("DECIMAL");
        
        PlatformConfiguration travelChargeConfig = new PlatformConfiguration();
        travelChargeConfig.setConfigKey("PRICING_TRAVEL_CHARGE_PER_KM");
        travelChargeConfig.setConfigValue("10.00");
        travelChargeConfig.setDataType("DECIMAL");
        
        PlatformConfiguration gstConfig = new PlatformConfiguration();
        gstConfig.setConfigKey("PRICING_GST_PERCENTAGE");
        gstConfig.setConfigValue("18.00");
        gstConfig.setDataType("DECIMAL");
        
        configRepository.save(basePriceConfig);
        configRepository.save(travelChargeConfig);
        configRepository.save(gstConfig);
    }

    @AfterEach
    void tearDown() {
        configRepository.deleteAll();
    }

    @Test
    void testCalculatePriceMath() {
        CalculatePriceRequest request = new CalculatePriceRequest();
        
        CalculatePriceResponse response = calculatePriceService.calculatePrice(request);
        
        assertThat(response.getBasePrice()).isEqualByComparingTo(new BigDecimal("250.00"));
        assertThat(response.getDistanceKm()).isEqualByComparingTo(new BigDecimal("3.4"));
        assertThat(response.getTravelCharge()).isEqualByComparingTo(new BigDecimal("34.00"));
        assertThat(response.getGst()).isEqualByComparingTo(new BigDecimal("51.12"));
        assertThat(response.getTotalPrice()).isEqualByComparingTo(new BigDecimal("335.12"));
    }
}
