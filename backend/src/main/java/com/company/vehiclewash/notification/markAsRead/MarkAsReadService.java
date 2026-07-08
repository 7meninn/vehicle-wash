package com.company.vehiclewash.notification.markAsRead;

import com.company.vehiclewash.common.exception.ResourceNotFoundException;
import com.company.vehiclewash.notification.entity.Notification;
import com.company.vehiclewash.notification.repository.NotificationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class MarkAsReadService {

    private final NotificationRepository notificationRepository;

    @Transactional
    public void markAsRead(UUID notificationId, UUID currentUserId) {
        Notification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> new ResourceNotFoundException("Notification not found with ID: " + notificationId));

        if (!notification.getRecipientId().equals(currentUserId)) {
            throw new RuntimeException("Unauthorized to access this notification");
        }

        if (!notification.isRead()) {
            notification.setRead(true);
            notification.setReadAt(LocalDateTime.now());
            notificationRepository.save(notification);
        }
    }
}
