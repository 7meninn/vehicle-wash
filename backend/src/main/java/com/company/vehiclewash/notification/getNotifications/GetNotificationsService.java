package com.company.vehiclewash.notification.getNotifications;

import com.company.vehiclewash.notification.entity.Notification;
import com.company.vehiclewash.notification.repository.NotificationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class GetNotificationsService {

    private final NotificationRepository notificationRepository;

    @Transactional(readOnly = true)
    public Page<NotificationResponse> getNotifications(UUID recipientId, Pageable pageable) {
        Page<Notification> notifications = notificationRepository.findByRecipientIdOrderBySentAtDesc(recipientId, pageable);
        
        return notifications.map(notification -> NotificationResponse.builder()
                .id(notification.getId())
                .notificationType(notification.getNotificationType())
                .title(notification.getTitle())
                .body(notification.getBody())
                .deliveryChannel(notification.getDeliveryChannel())
                .deliveryStatus(notification.getDeliveryStatus())
                .isRead(notification.isRead())
                .sentAt(notification.getSentAt())
                .readAt(notification.getReadAt())
                .build());
    }
}
