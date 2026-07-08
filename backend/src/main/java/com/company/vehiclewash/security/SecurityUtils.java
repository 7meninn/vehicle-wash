package com.company.vehiclewash.security;

import java.util.UUID;

public class SecurityUtils {
    
    private static final ThreadLocal<UUID> mockUserId = new ThreadLocal<>();
    private static final ThreadLocal<UUID> mockWasherId = new ThreadLocal<>();

    public static void setMockUserId(UUID id) { mockUserId.set(id); }
    public static void setMockWasherId(UUID id) { mockWasherId.set(id); }
    public static void clear() { mockUserId.remove(); mockWasherId.remove(); }

    public static UUID getCurrentUserId() {
        if (mockUserId.get() != null) return mockUserId.get();
        return UUID.fromString("00000000-0000-0000-0000-000000000000");
    }

    public static UUID getCurrentWasherId() {
        if (mockWasherId.get() != null) return mockWasherId.get();
        return UUID.fromString("11111111-1111-1111-1111-111111111111");
    }

    public static boolean hasRole(String role) {
        return false; // Mock implementation
    }
}
