import 'package:dio/dio.dart';
import '../models/earning_model.dart';
import '../models/payout_model.dart';

class EarningsRemoteDataSource {
  final Dio _dio;

  EarningsRemoteDataSource(this._dio);

  Future<EarningModel> getWeeklyEarnings(String weekStart, String weekEnd) async {
    final response = await _dio.get('/washers/me/earnings', queryParameters: {
      'weekStart': weekStart,
      'weekEnd': weekEnd,
    });
    return EarningModel.fromJson(response.data['data']);
  }

  Future<List<PayoutModel>> getPayoutHistory() async {
    final response = await _dio.get('/washers/me/payouts');
    final List<dynamic> data = response.data['data'];
    return data.map((json) => PayoutModel.fromJson(json)).toList();
  }
}
