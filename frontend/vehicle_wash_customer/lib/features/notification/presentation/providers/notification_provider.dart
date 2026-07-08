import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/repository_impl/notification_repository_impl.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/mark_notification_read_usecase.dart';

final notificationRemoteDataSourceProvider = Provider<NotificationRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NotificationRemoteDataSource(apiClient);
});

final notificationRepositoryProvider = Provider<NotificationRepositoryImpl>((ref) {
  final dataSource = ref.watch(notificationRemoteDataSourceProvider);
  return NotificationRepositoryImpl(dataSource);
});

final getNotificationsUseCaseProvider = Provider<GetNotificationsUseCase>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return GetNotificationsUseCase(repository);
});

final markNotificationReadUseCaseProvider = Provider<MarkNotificationReadUseCase>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return MarkNotificationReadUseCase(repository);
});

final notificationsProvider = AsyncNotifierProvider<NotificationsNotifier, List<NotificationEntity>>(() {
  return NotificationsNotifier();
});

class NotificationsNotifier extends AsyncNotifier<List<NotificationEntity>> {
  @override
  Future<List<NotificationEntity>> build() async {
    return _fetchNotifications();
  }

  Future<List<NotificationEntity>> _fetchNotifications() async {
    final useCase = ref.read(getNotificationsUseCaseProvider);
    return useCase(0, 50);
  }

  Future<void> markAsRead(String id) async {
    try {
      final markUseCase = ref.read(markNotificationReadUseCaseProvider);
      await markUseCase(id);
      
      state = state.whenData((notifications) {
        return notifications.map((n) {
          if (n.id == id) {
            return NotificationEntity(
              id: n.id,
              notificationType: n.notificationType,
              title: n.title,
              body: n.body,
              deliveryChannel: n.deliveryChannel,
              deliveryStatus: n.deliveryStatus,
              isRead: true,
              sentAt: n.sentAt,
              readAt: DateTime.now(),
            );
          }
          return n;
        }).toList();
      });
    } catch (e) {
      // Ignored for now
    }
  }
}