import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.notificationType,
    required super.title,
    required super.body,
    required super.deliveryChannel,
    required super.deliveryStatus,
    required super.isRead,
    required super.sentAt,
    super.readAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      notificationType: json['notificationType'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      deliveryChannel: json['deliveryChannel'] ?? '',
      deliveryStatus: json['deliveryStatus'] ?? '',
      isRead: json['isRead'] ?? false,
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt']) : DateTime.now(),
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
    );
  }
}