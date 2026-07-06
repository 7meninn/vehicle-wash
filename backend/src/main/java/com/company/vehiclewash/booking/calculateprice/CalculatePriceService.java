package com.company.vehiclewash.booking.calculateprice;

import com.company.vehiclewash.platform.entity.PlatformConfiguration;
import com.company.vehiclewash.platform.repository.PlatformConfigurationRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;

@Service
public class CalculatePriceService {

    private final PlatformConfigurationRepository configRepository;

    public CalculatePriceService(PlatformConfigurationRepository configRepository) {
        this.configRepository = configRepository;
    }

    @Transactional(readOnly = true)
    public CalculatePriceResponse calculatePrice(CalculatePriceRequest request) {
        // Fetch or default base price
        BigDecimal basePrice = getDecimalConfig("PRICING_BASE_PRICE", new BigDecimal("250.00"));
        
        // Fetch or default travel charge per km
        BigDecimal travelChargePerKm = getDecimalConfig("PRICING_TRAVEL_CHARGE_PER_KM", new BigDecimal("10.00"));
        
        // Fetch or default GST percentage
        BigDecimal gstPercentage = getDecimalConfig("PRICING_GST_PERCENTAGE", new BigDecimal("18.00"));

        // Mock distance calculation as instructed
        BigDecimal distanceKm = new BigDecimal("3.4");

        // Calculations
        BigDecimal travelCharge = travelChargePerKm.multiply(distanceKm).setScale(2, RoundingMode.HALF_UP);
        BigDecimal subTotal = basePrice.add(travelCharge);
        BigDecimal gstAmount = subTotal.multiply(gstPercentage).divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);
        BigDecimal totalAmount = subTotal.add(gstAmount);

        CalculatePriceResponse response = new CalculatePriceResponse();
        response.setBasePrice(basePrice);
        response.setDistanceKm(distanceKm);
        response.setTravelCharge(travelCharge);
        response.setGst(gstAmount);
        response.setTotalPrice(totalAmount);

        return response;
    }

    private BigDecimal getDecimalConfig(String key, BigDecimal defaultValue) {
        return configRepository.findByConfigKey(key)
                .map(PlatformConfiguration::getConfigValue)
                .map(BigDecimal::new)
                .orElse(defaultValue);
    }
}
