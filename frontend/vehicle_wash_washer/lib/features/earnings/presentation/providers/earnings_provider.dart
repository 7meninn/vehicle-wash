import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../../data/datasources/earnings_remote_datasource.dart';
import '../../data/repository_impl/earnings_repository_impl.dart';
import '../../domain/entities/earning.dart';
import '../../domain/entities/payout.dart';
import '../../domain/repositories/earnings_repository.dart';

final earningsRemoteDataSourceProvider = Provider<EarningsRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return EarningsRemoteDataSource(apiClient.dio);
});

final earningsRepositoryProvider = Provider<EarningsRepository>((ref) {
  final remoteDataSource = ref.watch(earningsRemoteDataSourceProvider);
  return EarningsRepositoryImpl(remoteDataSource);
});

final weeklyEarningsProvider = FutureProvider.family<Earning, Map<String, String>>((ref, params) async {
  final repository = ref.watch(earningsRepositoryProvider);
  return repository.getWeeklyEarnings(params['weekStart']!, params['weekEnd']!);
});

final payoutHistoryProvider = FutureProvider<List<Payout>>((ref) async {
  final repository = ref.watch(earningsRepositoryProvider);
  return repository.getPayoutHistory();
});
