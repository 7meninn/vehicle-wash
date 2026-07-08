package com.company.vehiclewash.notification;

import com.company.vehiclewash.AbstractIntegrationTest;
import com.company.vehiclewash.notification.entity.Notification;
import com.company.vehiclewash.notification.enums.DeliveryChannel;
import com.company.vehiclewash.notification.enums.NotificationType;
import com.company.vehiclewash.notification.enums.RecipientType;
import com.company.vehiclewash.notification.repository.NotificationRepository;
import com.company.vehiclewash.notification.sendNotification.SendNotificationRequest;
import com.company.vehiclewash.security.SecurityUtils;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

public class NotificationIntegrationTest extends AbstractIntegrationTest {

    @Autowired
    private NotificationRepository notificationRepository;

    @Test
    public void testNotificationFlow() throws Exception {
        String adminToken = getAdminToken("4445556667");
        String customerToken = getCustomerToken("1231231234");
        UUID customerId = SecurityUtils.getCurrentUserId();

        // 1. Send Notification (By Admin)
        SendNotificationRequest sendReq = new SendNotificationRequest();
        sendReq.setRecipientType(RecipientType.CUSTOMER);
        sendReq.setRecipientId(customerId);
        sendReq.setNotificationType(NotificationType.GENERAL);
        sendReq.setTitle("Welcome");
        sendReq.setBody("Welcome to Vehicle Wash!");
        sendReq.setDeliveryChannel(DeliveryChannel.PUSH);

        mockMvc.perform(post("/admin/notifications")
                .header("Authorization", adminToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(sendReq)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        List<Notification> notifications = notificationRepository.findAll();
        assertEquals(1, notifications.size());
        Notification notification = notifications.get(0);
        assertEquals("Welcome", notification.getTitle());
        assertFalse(notification.isRead());

        // 2. Get Notifications (By Customer)
        mockMvc.perform(get("/notifications")
                .header("Authorization", customerToken)
                .param("page", "0")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true))
                .andExpect(jsonPath("$.data.content[0].id").value(notification.getId().toString()))
                .andExpect(jsonPath("$.data.content[0].read").value(false));

        // 3. Mark as Read (By Customer)
        mockMvc.perform(patch("/notifications/" + notification.getId() + "/read")
                .header("Authorization", customerToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));

        Notification updatedNotification = notificationRepository.findById(notification.getId()).get();
        assertTrue(updatedNotification.isRead());
    }
}
