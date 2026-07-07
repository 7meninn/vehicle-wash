import 'package:dio/dio.dart';
import '../models/history_booking_model.dart';

class HistoryRemoteDataSource {
  final Dio _dio;

  HistoryRemoteDataSource(this._dio);

  Future<List<HistoryBookingModel>> getBookingHistory({
    int page = 0,
    int size = 20,
    String? status,
    String? date,
  }) async {
    final Map<String, dynamic> queryParameters = {
      'page': page,
      'size': size,
    };
    if (status != null) queryParameters['status'] = status;
    if (date != null) queryParameters['date'] = date;

    final response = await _dio.get('/washers/me/bookings', queryParameters: queryParameters);
    
    final dynamic responseData = response.data['data'];
    final List<dynamic> data = responseData is List ? responseData : (responseData['content'] ?? []);
    return data.map((json) => HistoryBookingModel.fromJson(json)).toList();
  }
}
