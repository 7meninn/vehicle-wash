package com.company.vehiclewash.notification.getNotifications;

import com.company.vehiclewash.common.response.ApiResponse;
import com.company.vehiclewash.security.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/notifications")
@RequiredArgsConstructor
public class GetNotificationsController {

    private final GetNotificationsService getNotificationsService;

    @GetMapping
    public ApiResponse<Page<NotificationResponse>> getNotifications(Pageable pageable) {
        UUID currentUserId = SecurityUtils.getCurrentUserId();
        Page<NotificationResponse> responses = getNotificationsService.getNotifications(currentUserId, pageable);
        return ApiResponse.success(responses);
    }
}
