import '../entities/history_booking.dart';

abstract class HistoryRepository {
  Future<List<HistoryBooking>> getBookingHistory({
    int page = 0,
    int size = 20,
    String? status,
    String? date,
  });
}
