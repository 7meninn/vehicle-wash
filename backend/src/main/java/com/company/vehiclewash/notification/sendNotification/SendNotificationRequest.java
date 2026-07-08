package com.company.vehiclewash.notification.sendNotification;

import com.company.vehiclewash.notification.enums.DeliveryChannel;
import com.company.vehiclewash.notification.enums.NotificationType;
import com.company.vehiclewash.notification.enums.RecipientType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.UUID;

@Data
public class SendNotificationRequest {

    @NotNull(message = "Recipient Type is required")
    private RecipientType recipientType;

    @NotNull(message = "Recipient ID is required")
    private UUID recipientId;

    @NotNull(message = "Notification Type is required")
    private NotificationType notificationType;

    @NotBlank(message = "Title is required")
    private String title;

    @NotBlank(message = "Body is required")
    private String body;

    @NotNull(message = "Delivery Channel is required")
    private DeliveryChannel deliveryChannel;
}
