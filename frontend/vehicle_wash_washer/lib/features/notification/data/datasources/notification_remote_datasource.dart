import 'package:vehicle_wash_shared/core/network/api_client.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications(int page, int size);
  Future<void> markAsRead(String notificationId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient apiClient;

  NotificationRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<NotificationModel>> getNotifications(int page, int size) async {
    final response = await apiClient.dio.get(
      '/notifications',
      queryParameters: {'page': page, 'size': size},
    );
    
    final data = response.data['data'];
    if (data != null && data['content'] != null) {
      final content = data['content'] as List;
      return content.map((e) => NotificationModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await apiClient.dio.patch('/notifications/$notificationId/read');
  }
}
