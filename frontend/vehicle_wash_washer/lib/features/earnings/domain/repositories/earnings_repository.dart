import '../entities/earning.dart';
import '../entities/payout.dart';

abstract class EarningsRepository {
  Future<Earning> getWeeklyEarnings(String weekStart, String weekEnd);
  Future<List<Payout>> getPayoutHistory();
}
