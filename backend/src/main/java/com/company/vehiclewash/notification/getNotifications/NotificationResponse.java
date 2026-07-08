package com.company.vehiclewash.notification.getNotifications;

import com.company.vehiclewash.notification.enums.DeliveryChannel;
import com.company.vehiclewash.notification.enums.DeliveryStatus;
import com.company.vehiclewash.notification.enums.NotificationType;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
public class NotificationResponse {
    private UUID id;
    private NotificationType notificationType;
    private String title;
    private String body;
    private DeliveryChannel deliveryChannel;
    private DeliveryStatus deliveryStatus;
    private boolean isRead;
    private LocalDateTime sentAt;
    private LocalDateTime readAt;
}
