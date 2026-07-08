import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<List<NotificationEntity>> call(int page, int size) {
    return _repository.getNotifications(page, size);
  }
}