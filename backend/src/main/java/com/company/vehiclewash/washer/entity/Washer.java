package com.company.vehiclewash.washer.entity;

import com.company.vehiclewash.washer.enums.VerificationStatus;
import com.company.vehiclewash.washer.enums.WasherVehicleType;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "washers")
public class Washer {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Enumerated(EnumType.STRING)
    @Column(name = "vehicle_type")
    private WasherVehicleType vehicleType;

    @Column(name = "mobile_number", nullable = false, length = 15, unique = true)
    private String mobileNumber;

    @Column(name = "full_name", nullable = false, length = 150)
    private String fullName;

    @Column(name = "home_address", columnDefinition = "TEXT")
    private String homeAddress;

    @Column(name = "home_latitude", precision = 10, scale = 7)
    private BigDecimal homeLatitude;

    @Column(name = "home_longitude", precision = 10, scale = 7)
    private BigDecimal homeLongitude;

    @Enumerated(EnumType.STRING)
    @Column(name = "verification_status")
    private VerificationStatus verificationStatus;

    @Column(name = "trust_score", precision = 5, scale = 2)
    private BigDecimal trustScore;

    @Column(name = "average_rating", precision = 3, scale = 2)
    private BigDecimal averageRating;

    @Column(name = "total_completed_jobs")
    private Integer totalCompletedJobs;

    @Column(name = "weekly_capacity_override")
    private Integer weeklyCapacityOverride;

    @Column(name = "is_active")
    private Boolean isActive = true;

    @Column(name = "created_at", nullable = false, updatable = false)
    private Instant createdAt = Instant.now();

    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt = Instant.now();

    @Version
    @Column(name = "version")
    private Integer version;

    @PrePersist
    protected void onCreate() {
        createdAt = Instant.now();
        updatedAt = Instant.now();
        if (trustScore == null) trustScore = new BigDecimal("100.00");
        if (averageRating == null) averageRating = new BigDecimal("5.00");
        if (totalCompletedJobs == null) totalCompletedJobs = 0;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = Instant.now();
    }

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }
    
    public WasherVehicleType getVehicleType() { return vehicleType; }
    public void setVehicleType(WasherVehicleType vehicleType) { this.vehicleType = vehicleType; }
    
    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getHomeAddress() { return homeAddress; }
    public void setHomeAddress(String homeAddress) { this.homeAddress = homeAddress; }
    
    public BigDecimal getHomeLatitude() { return homeLatitude; }
    public void setHomeLatitude(BigDecimal homeLatitude) { this.homeLatitude = homeLatitude; }
    
    public BigDecimal getHomeLongitude() { return homeLongitude; }
    public void setHomeLongitude(BigDecimal homeLongitude) { this.homeLongitude = homeLongitude; }
    
    public VerificationStatus getVerificationStatus() { return verificationStatus; }
    public void setVerificationStatus(VerificationStatus verificationStatus) { this.verificationStatus = verificationStatus; }
    
    public BigDecimal getTrustScore() { return trustScore; }
    public void setTrustScore(BigDecimal trustScore) { this.trustScore = trustScore; }
    
    public BigDecimal getAverageRating() { return averageRating; }
    public void setAverageRating(BigDecimal averageRating) { this.averageRating = averageRating; }
    
    public Integer getTotalCompletedJobs() { return totalCompletedJobs; }
    public void setTotalCompletedJobs(Integer totalCompletedJobs) { this.totalCompletedJobs = totalCompletedJobs; }
    
    public Integer getWeeklyCapacityOverride() { return weeklyCapacityOverride; }
    public void setWeeklyCapacityOverride(Integer weeklyCapacityOverride) { this.weeklyCapacityOverride = weeklyCapacityOverride; }
    
    public Boolean getActive() { return isActive; }
    public void setActive(Boolean active) { isActive = active; }
    
    public Instant getCreatedAt() { return createdAt; }
    public void setCreatedAt(Instant createdAt) { this.createdAt = createdAt; }
    
    public Instant getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Instant updatedAt) { this.updatedAt = updatedAt; }
    
    public Integer getVersion() { return version; }
    public void setVersion(Integer version) { this.version = version; }
}
