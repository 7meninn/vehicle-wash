import '../../domain/entities/booking.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_remote_datasource.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource _remoteDataSource;

  HistoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Booking>> getBookingHistory({int page = 0, int size = 20}) async {
    return await _remoteDataSource.getBookingHistory(page: page, size: size);
  }
}
