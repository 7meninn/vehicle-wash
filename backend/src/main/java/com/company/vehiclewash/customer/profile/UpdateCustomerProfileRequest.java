package com.company.vehiclewash.customer.profile;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class UpdateCustomerProfileRequest {
    @NotBlank(message = "Full name is required")
    @Size(max = 150)
    private String fullName;
    
    @Email(message = "Invalid email format")
    @Size(max = 255)
    private String email;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
