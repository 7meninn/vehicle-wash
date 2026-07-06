package com.company.vehiclewash.customer.addAddress;

import com.company.vehiclewash.customer.entity.CustomerAddress;
import com.company.vehiclewash.customer.repository.CustomerAddressRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class AddAddressService {

    private final CustomerAddressRepository addressRepository;

    public AddAddressService(CustomerAddressRepository addressRepository) {
        this.addressRepository = addressRepository;
    }

    @Transactional
    public void addAddress(AddAddressRequest request) {
        UUID customerId = SecurityUtils.getCurrentUserId();

        CustomerAddress address = new CustomerAddress();
        address.setCustomerId(customerId);
        address.setAddressLabel(request.getLabel());
        address.setFullAddress(request.getAddress());
        address.setLatitude(request.getLatitude());
        address.setLongitude(request.getLongitude());

        boolean isFirstAddress = addressRepository.findByCustomerId(customerId).isEmpty();
        address.setDefault(isFirstAddress);

        addressRepository.save(address);
    }
}
