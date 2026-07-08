import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';

class NotificationRemoteDataSource {
  final ApiClient _apiClient;

  NotificationRemoteDataSource(this._apiClient);

  Future<Map<String, dynamic>> getNotifications(int page, int size) async {
    final response = await _apiClient.dio.get('/notifications', queryParameters: {
      'page': page,
      'size': size,
    });
    return response.data;
  }

  Future<void> markAsRead(String id) async {
    await _apiClient.dio.patch('/notifications//read');
  }
}