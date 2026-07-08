package com.company.vehiclewash.notification.markAsRead;

import com.company.vehiclewash.common.response.ApiResponse;
import com.company.vehiclewash.security.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/notifications")
@RequiredArgsConstructor
public class MarkAsReadController {

    private final MarkAsReadService markAsReadService;

    @PatchMapping("/{id}/read")
    public ApiResponse<Void> markAsRead(@PathVariable("id") UUID notificationId) {
        UUID currentUserId = SecurityUtils.getCurrentUserId();
        markAsReadService.markAsRead(notificationId, currentUserId);
        return ApiResponse.success(null);
    }
}
