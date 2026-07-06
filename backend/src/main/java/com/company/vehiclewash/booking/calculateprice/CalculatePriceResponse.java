package com.company.vehiclewash.booking.calculateprice;

import java.math.BigDecimal;

public class CalculatePriceResponse {
    private BigDecimal basePrice;
    private BigDecimal distanceKm;
    private BigDecimal travelCharge;
    private BigDecimal gst;
    private BigDecimal totalPrice;

    public BigDecimal getBasePrice() { return basePrice; }
    public void setBasePrice(BigDecimal basePrice) { this.basePrice = basePrice; }

    public BigDecimal getDistanceKm() { return distanceKm; }
    public void setDistanceKm(BigDecimal distanceKm) { this.distanceKm = distanceKm; }

    public BigDecimal getTravelCharge() { return travelCharge; }
    public void setTravelCharge(BigDecimal travelCharge) { this.travelCharge = travelCharge; }

    public BigDecimal getGst() { return gst; }
    public void setGst(BigDecimal gst) { this.gst = gst; }

    public BigDecimal getTotalPrice() { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalPrice = totalPrice; }
}
