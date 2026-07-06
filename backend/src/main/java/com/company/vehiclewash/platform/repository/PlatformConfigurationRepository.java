package com.company.vehiclewash.platform.repository;

import com.company.vehiclewash.platform.entity.PlatformConfiguration;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
import java.util.UUID;

public interface PlatformConfigurationRepository extends JpaRepository<PlatformConfiguration, UUID> {
    Optional<PlatformConfiguration> findByConfigKey(String configKey);
}
