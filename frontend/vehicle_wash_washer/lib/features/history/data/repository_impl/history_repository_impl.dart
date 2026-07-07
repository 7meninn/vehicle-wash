import '../../domain/entities/history_booking.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_remote_datasource.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource _remoteDataSource;

  HistoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<HistoryBooking>> getBookingHistory({
    int page = 0,
    int size = 20,
    String? status,
    String? date,
  }) async {
    return await _remoteDataSource.getBookingHistory(
      page: page,
      size: size,
      status: status,
      date: date,
    );
  }
}
