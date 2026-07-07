import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../../data/datasources/history_remote_datasource.dart';
import '../../data/repository_impl/history_repository_impl.dart';
import '../../domain/entities/history_booking.dart';
import '../../domain/repositories/history_repository.dart';

final historyRemoteDataSourceProvider = Provider<HistoryRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return HistoryRemoteDataSource(apiClient.dio);
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  final remoteDataSource = ref.watch(historyRemoteDataSourceProvider);
  return HistoryRepositoryImpl(remoteDataSource);
});

final bookingHistoryProvider = FutureProvider.family<List<HistoryBooking>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(historyRepositoryProvider);
  return repository.getBookingHistory(
    page: params['page'] ?? 0,
    size: params['size'] ?? 20,
    status: params['status'],
    date: params['date'],
  );
});
