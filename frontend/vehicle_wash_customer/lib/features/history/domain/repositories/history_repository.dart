import '../entities/booking.dart';

abstract class HistoryRepository {
  Future<List<Booking>> getBookingHistory({int page = 0, int size = 20});
}
