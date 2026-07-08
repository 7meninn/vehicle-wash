package com.company.vehiclewash.notification.sendNotification;

import com.company.vehiclewash.common.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/notifications")
@RequiredArgsConstructor
public class SendNotificationController {

    private final SendNotificationService sendNotificationService;

    @PostMapping
    @PreAuthorize("hasRole('ADMIN') or hasRole('SUPER_ADMIN')")
    public ApiResponse<Void> sendNotification(@Valid @RequestBody SendNotificationRequest request) {
        sendNotificationService.sendNotification(request);
        return ApiResponse.success(null);
    }
}
