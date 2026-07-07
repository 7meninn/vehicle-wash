package com.company.vehiclewash.customer.profile;

import com.company.vehiclewash.auth.entity.User;
import com.company.vehiclewash.auth.repository.UserRepository;
import com.company.vehiclewash.common.exception.ResourceNotFoundException;
import com.company.vehiclewash.customer.entity.Customer;
import com.company.vehiclewash.customer.repository.CustomerRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CustomerProfileService {

    private final CustomerRepository customerRepository;
    private final UserRepository userRepository;

    public CustomerProfileService(CustomerRepository customerRepository, UserRepository userRepository) {
        this.customerRepository = customerRepository;
        this.userRepository = userRepository;
    }

    @Transactional(readOnly = true)
    public CustomerProfileResponse getProfile() {
        Customer customer = getAuthenticatedCustomer();
        return mapToResponse(customer);
    }

    @Transactional
    public CustomerProfileResponse updateProfile(UpdateCustomerProfileRequest request) {
        Customer customer = getAuthenticatedCustomer();
        customer.setFullName(request.getFullName());
        if (request.getEmail() != null) {
            customer.setEmail(request.getEmail());
        }
        Customer updatedCustomer = customerRepository.save(customer);
        return mapToResponse(updatedCustomer);
    }

    private Customer getAuthenticatedCustomer() {
        User user = userRepository.findById(SecurityUtils.getCurrentUserId())
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        return customerRepository.findByMobileNumber(user.getMobileNumber())
                .orElseThrow(() -> new ResourceNotFoundException("Customer profile not found"));
    }

    private CustomerProfileResponse mapToResponse(Customer customer) {
        CustomerProfileResponse response = new CustomerProfileResponse();
        response.setId(customer.getId());
        response.setFullName(customer.getFullName());
        response.setMobileNumber(customer.getMobileNumber());
        response.setEmail(customer.getEmail());
        response.setReliabilityScore(customer.getReliabilityScore());
        return response;
    }
}
