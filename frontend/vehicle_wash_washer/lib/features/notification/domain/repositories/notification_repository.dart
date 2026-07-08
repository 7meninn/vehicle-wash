import '../../data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotifications(int page, int size);
  Future<void> markAsRead(String notificationId);
}
