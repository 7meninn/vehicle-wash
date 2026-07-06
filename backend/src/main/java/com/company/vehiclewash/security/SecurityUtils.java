package com.company.vehiclewash.security;

import java.util.UUID;

public class SecurityUtils {
    
    // In a real application, this would extract the UUID from the SecurityContext
    // For now, we return a mock UUID to simulate the logged-in user
    public static UUID getCurrentUserId() {
        return UUID.fromString("00000000-0000-0000-0000-000000000000");
    }

    // Mock for getting the current washer's ID
    public static UUID getCurrentWasherId() {
        return UUID.fromString("11111111-1111-1111-1111-111111111111");
    }
}
