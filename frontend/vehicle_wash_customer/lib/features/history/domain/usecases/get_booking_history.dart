import '../entities/booking.dart';
import '../repositories/history_repository.dart';

class GetBookingHistoryUseCase {
  final HistoryRepository _repository;

  GetBookingHistoryUseCase(this._repository);

  Future<List<Booking>> execute({int page = 0, int size = 20}) {
    return _repository.getBookingHistory(page: page, size: size);
  }
}
