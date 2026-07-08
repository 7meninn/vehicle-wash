import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_datasource.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _dataSource;

  NotificationRepositoryImpl(this._dataSource);

  @override
  Future<List<NotificationEntity>> getNotifications(int page, int size) async {
    final result = await _dataSource.getNotifications(page, size);
    final data = result['data']?['content'] as List? ?? [];
    return data.map((json) => NotificationModel.fromJson(json)).toList();
  }

  @override
  Future<void> markAsRead(String id) async {
    await _dataSource.markAsRead(id);
  }
}