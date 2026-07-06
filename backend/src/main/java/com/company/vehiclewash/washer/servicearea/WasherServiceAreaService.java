package com.company.vehiclewash.washer.servicearea;

import com.company.vehiclewash.security.SecurityUtils;
import com.company.vehiclewash.washer.entity.ServiceArea;
import com.company.vehiclewash.washer.entity.WasherServiceArea;
import com.company.vehiclewash.washer.repository.ServiceAreaRepository;
import com.company.vehiclewash.washer.repository.WasherServiceAreaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class WasherServiceAreaService {

    private final WasherServiceAreaRepository washerServiceAreaRepository;
    private final ServiceAreaRepository serviceAreaRepository;

    public WasherServiceAreaService(
            WasherServiceAreaRepository washerServiceAreaRepository,
            ServiceAreaRepository serviceAreaRepository) {
        this.washerServiceAreaRepository = washerServiceAreaRepository;
        this.serviceAreaRepository = serviceAreaRepository;
    }

    @Transactional(readOnly = true)
    public List<ServiceAreaResponse> getServiceAreas() {
        UUID washerId = SecurityUtils.getCurrentWasherId();

        List<UUID> serviceAreaIds = washerServiceAreaRepository.findByWasherId(washerId)
                .stream()
                .map(WasherServiceArea::getServiceAreaId)
                .collect(Collectors.toList());

        List<ServiceArea> areas = serviceAreaRepository.findAllById(serviceAreaIds);

        return areas.stream().map(area -> {
            ServiceAreaResponse response = new ServiceAreaResponse();
            response.setId(area.getId());
            response.setName(area.getName());
            response.setPolygonGeojson(area.getPolygonGeojson());
            response.setActive(area.getActive());
            return response;
        }).collect(Collectors.toList());
    }

    @Transactional
    public void updateServiceAreas(UpdateServiceAreasRequest request) {
        UUID washerId = SecurityUtils.getCurrentWasherId();

        // Validate that all service areas exist
        List<ServiceArea> existingAreas = serviceAreaRepository.findAllById(request.getServiceAreaIds());
        if (existingAreas.size() != request.getServiceAreaIds().size()) {
            throw new RuntimeException("One or more service areas do not exist");
        }

        // Validate that only active service areas can be selected
        boolean allActive = existingAreas.stream().allMatch(ServiceArea::getActive);
        if (!allActive) {
            throw new RuntimeException("Cannot assign inactive service areas");
        }

        // Overwrite existing mapping
        washerServiceAreaRepository.deleteByWasherId(washerId);

        List<WasherServiceArea> newMappings = request.getServiceAreaIds().stream()
                .map(areaId -> {
                    WasherServiceArea mapping = new WasherServiceArea();
                    mapping.setWasherId(washerId);
                    mapping.setServiceAreaId(areaId);
                    return mapping;
                })
                .collect(Collectors.toList());

        washerServiceAreaRepository.saveAll(newMappings);
    }
}
