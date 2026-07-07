package com.company.vehiclewash.washer.profile;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class UpdateWasherProfileRequest {
    @NotBlank(message = "Full name is required")
    @Size(max = 150)
    private String fullName;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}
