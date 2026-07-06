package com.company.vehiclewash.customer.getAddresses;

import com.company.vehiclewash.customer.repository.CustomerAddressRepository;
import com.company.vehiclewash.security.SecurityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class GetAddressesService {

    private final CustomerAddressRepository addressRepository;

    public GetAddressesService(CustomerAddressRepository addressRepository) {
        this.addressRepository = addressRepository;
    }

    @Transactional(readOnly = true)
    public List<AddressResponse> getAddresses() {
        UUID customerId = SecurityUtils.getCurrentUserId();

        return addressRepository.findByCustomerId(customerId).stream()
                .map(address -> {
                    AddressResponse response = new AddressResponse();
                    response.setId(address.getId());
                    response.setLabel(address.getAddressLabel());
                    response.setAddress(address.getFullAddress());
                    response.setLatitude(address.getLatitude());
                    response.setLongitude(address.getLongitude());
                    response.setDefault(address.getDefault());
                    return response;
                })
                .collect(Collectors.toList());
    }
}
