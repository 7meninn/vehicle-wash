class NotificationModel {
  final String id;
  final String notificationType;
  final String title;
  final String body;
  final String deliveryChannel;
  final String deliveryStatus;
  final bool isRead;
  final DateTime sentAt;
  final DateTime? readAt;

  NotificationModel({
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
