import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';

import '../../data/datasources/history_remote_datasource.dart';
import '../../data/repository_impl/history_repository_impl.dart';
import '../../domain/entities/booking.dart';
import '../../domain/repositories/history_repository.dart';
import '../../domain/usecases/get_booking_history.dart';

final historyRemoteDataSourceProvider = Provider<HistoryRemoteDataSource>((ref) {
  return HistoryRemoteDataSource(ref.watch(apiClientProvider));
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepositoryImpl(ref.watch(historyRemoteDataSourceProvider));
});

final getBookingHistoryUseCaseProvider = Provider<GetBookingHistoryUseCase>((ref) {
  return GetBookingHistoryUseCase(ref.watch(historyRepositoryProvider));
});

final bookingHistoryProvider = AsyncNotifierProvider<BookingHistoryNotifier, List<Booking>>(() {
  return BookingHistoryNotifier();
});

class BookingHistoryNotifier extends AsyncNotifier<List<Booking>> {
  @override
  Future<List<Booking>> build() async {
    return ref.watch(getBookingHistoryUseCaseProvider).execute();
  }

  Future<void> refreshHistory() async {
    state = const AsyncValue.loading();
    try {
      final history = await ref.read(getBookingHistoryUseCaseProvider).execute();
      state = AsyncValue.data(history);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
