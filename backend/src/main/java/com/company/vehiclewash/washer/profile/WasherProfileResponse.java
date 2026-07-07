package com.company.vehiclewash.washer.profile;

import com.company.vehiclewash.washer.enums.VerificationStatus;
import java.math.BigDecimal;
import java.util.Map;
import java.util.UUID;

public class WasherProfileResponse {
    private UUID id;
    private String fullName;
    private String mobileNumber;
    private VerificationStatus verificationStatus;
    private BigDecimal averageRating;
    private BigDecimal trustScore;
    private Integer totalCompletedJobs;
    private Map<String, Object> homeBase;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public VerificationStatus getVerificationStatus() {
        return verificationStatus;
    }

    public void setVerificationStatus(VerificationStatus verificationStatus) {
        this.verificationStatus = verificationStatus;
    }

    public BigDecimal getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(BigDecimal averageRating) {
        this.averageRating = averageRating;
    }

    public BigDecimal getTrustScore() {
        return trustScore;
    }

    public void setTrustScore(BigDecimal trustScore) {
        this.trustScore = trustScore;
    }

    public Integer getTotalCompletedJobs() {
        return totalCompletedJobs;
    }

    public void setTotalCompletedJobs(Integer totalCompletedJobs) {
        this.totalCompletedJobs = totalCompletedJobs;
    }

    public Map<String, Object> getHomeBase() {
        return homeBase;
    }

    public void setHomeBase(Map<String, Object> homeBase) {
        this.homeBase = homeBase;
    }
}
