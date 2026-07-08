class NotificationEntity {
  final String id;
  final String notificationType;
  final String title;
  final String body;
  final String deliveryChannel;
  final String deliveryStatus;
  final bool isRead;
  final DateTime sentAt;
  final DateTime? readAt;

  NotificationEntity({
    required this.id,
    required this.notificationType,
    required this.title,
    required this.body,
    required this.deliveryChannel,
    required this.deliveryStatus,
    required this.isRead,
    required this.sentAt,
    this.readAt,
  });
}