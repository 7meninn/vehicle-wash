package com.company.vehiclewash.customer.repository;

import com.company.vehiclewash.customer.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import java.util.UUID;

public interface CustomerRepository extends JpaRepository<Customer, UUID> {
    Optional<Customer> findByMobileNumber(String mobileNumber);
}
