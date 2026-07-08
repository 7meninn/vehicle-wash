import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getNotifications(int page, int size);
  Future<void> markAsRead(String id);
}