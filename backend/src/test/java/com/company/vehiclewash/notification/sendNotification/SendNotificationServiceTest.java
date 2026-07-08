package com.company.vehiclewash.notification.sendNotification;

import com.company.vehiclewash.notification.entity.Notification;
import com.company.vehiclewash.notification.enums.DeliveryChannel;
import com.company.vehiclewash.notification.enums.DeliveryStatus;
import com.company.vehiclewash.notification.enums.NotificationType;
import com.company.vehiclewash.notification.enums.RecipientType;
import com.company.vehiclewash.notification.repository.NotificationRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
public class SendNotificationServiceTest {

    @Mock
    private NotificationRepository notificationRepository;

    @InjectMocks
    private SendNotificationService sendNotificationService;

    @Test
    public void testSendNotification_Success() {
        SendNotificationRequest req = new SendNotificationRequest();
        req.setRecipientType(RecipientType.CUSTOMER);
        req.setRecipientId(UUID.randomUUID());
        req.setNotificationType(NotificationType.GENERAL);
        req.setTitle("Test Title");
        req.setBody("Test Body");
        req.setDeliveryChannel(DeliveryChannel.PUSH);

        sendNotificationService.sendNotification(req);

        ArgumentCaptor<Notification> notificationCaptor = ArgumentCaptor.forClass(Notification.class);
        org.mockito.Mockito.verify(notificationRepository, org.mockito.Mockito.times(2)).save(notificationCaptor.capture());

        Notification savedNotification = notificationCaptor.getValue();
        assertEquals(req.getRecipientId(), savedNotification.getRecipientId());
        assertEquals("Test Title", savedNotification.getTitle());
        assertEquals("Test Body", savedNotification.getBody());
        assertEquals(DeliveryStatus.SENT, savedNotification.getDeliveryStatus());
    }
}
