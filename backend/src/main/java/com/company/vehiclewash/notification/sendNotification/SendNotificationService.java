package com.company.vehiclewash.notification.sendNotification;

import com.company.vehiclewash.notification.entity.Notification;
import com.company.vehiclewash.notification.enums.DeliveryStatus;
import com.company.vehiclewash.notification.repository.NotificationRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
public class SendNotificationService {

    private final NotificationRepository notificationRepository;

    @Transactional
    public void sendNotification(SendNotificationRequest request) {
        log.info("Sending notification to recipient: {}", request.getRecipientId());

        Notification notification = Notification.builder()
                .recipientType(request.getRecipientType())
                .recipientId(request.getRecipientId())
                .notificationType(request.getNotificationType())
                .title(request.getTitle())
                .body(request.getBody())
                .deliveryChannel(request.getDeliveryChannel())
                .deliveryStatus(DeliveryStatus.QUEUED)
                .isRead(false)
                .build();

        notificationRepository.save(notification);

        // Here we would typically integrate with FCM, Email Service, or SMS Gateway.
        // For MVP, we save the notification as QUEUED, then simulate sending.
        notification.setDeliveryStatus(DeliveryStatus.SENT);
        notificationRepository.save(notification);
        
        log.info("Notification successfully sent and recorded.");
    }
}
