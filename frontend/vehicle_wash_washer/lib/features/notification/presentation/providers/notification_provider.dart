import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_shared/core/providers/core_providers.dart';
import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/repository_impl/notification_repository_impl.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../data/models/notification_model.dart';

final notificationRemoteDataSourceProvider = Provider<NotificationRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NotificationRemoteDataSourceImpl(apiClient);
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final dataSource = ref.watch(notificationRemoteDataSourceProvider);
  return NotificationRepositoryImpl(dataSource);
});

class NotificationNotifier extends StateNotifier<AsyncValue<List<NotificationModel>>> {
  final NotificationRepository repository;

  NotificationNotifier(this.repository) : super(const AsyncValue.loading()) {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      state = const AsyncValue.loading();
      final notifications = await repository.getNotifications(0, 50);
      state = AsyncValue.data(notifications);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await repository.markAsRead(id);
      
      if (state.value != null) {
        final currentList = state.value!;
        final updatedList = currentList.map((notification) {
          if (notification.id == id && !notification.isRead) {
            return NotificationModel(
              id: notification.id,
              notificationType: notification.notificationType,
              title: notification.title,
              body: notification.body,
              deliveryChannel: notification.deliveryChannel,
              deliveryStatus: notification.deliveryStatus,
              isRead: true,
              sentAt: notification.sentAt,
              readAt: DateTime.now(),
            );
          }
          return notification;
        }).toList();
        state = AsyncValue.data(updatedList);
      }
    } catch (e) {
      // Handle error quietly
    }
  }
}

final notificationNotifierProvider = StateNotifierProvider.autoDispose<NotificationNotifier, AsyncValue<List<NotificationModel>>>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationNotifier(repository);
});
