import '../../domain/entities/earning.dart';
import '../../domain/entities/payout.dart';
import '../../domain/repositories/earnings_repository.dart';
import '../datasources/earnings_remote_datasource.dart';

class EarningsRepositoryImpl implements EarningsRepository {
  final EarningsRemoteDataSource _remoteDataSource;

  EarningsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Earning> getWeeklyEarnings(String weekStart, String weekEnd) async {
    return await _remoteDataSource.getWeeklyEarnings(weekStart, weekEnd);
  }

  @override
  Future<List<Payout>> getPayoutHistory() async {
    return await _remoteDataSource.getPayoutHistory();
  }
}
