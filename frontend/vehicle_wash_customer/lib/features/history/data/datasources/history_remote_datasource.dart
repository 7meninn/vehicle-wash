import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../models/booking_model.dart';

class HistoryRemoteDataSource {
  final ApiClient _apiClient;

  HistoryRemoteDataSource(this._apiClient);

  Future<List<BookingModel>> getBookingHistory({int page = 0, int size = 20}) async {
    final response = await _apiClient.dio.get(
      '/bookings',
      queryParameters: {
        'page': page,
        'size': size,
        'sort': 'createdAt,desc',
      },
    );
    
    final data = response.data['data'];
    // Assuming data contains a 'content' field for pagination or is a direct list
    final List<dynamic> list = data['content'] ?? data ?? [];
    
    return list.map((json) => BookingModel.fromJson(json)).toList();
  }
}
