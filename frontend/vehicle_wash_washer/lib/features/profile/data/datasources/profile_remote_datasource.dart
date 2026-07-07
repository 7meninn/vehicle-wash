import 'package:dio/dio.dart';
import '../models/washer_profile_model.dart';

class ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSource(this._dio);

  Future<WasherProfileModel> getProfile() async {
    final response = await _dio.get('/washers/me');
    return WasherProfileModel.fromJson(response.data['data']);
  }

  Future<void> updateProfile({required String fullName}) async {
    await _dio.put('/washers/me', data: {
      'fullName': fullName,
    });
  }

  Future<String> getVerificationStatus() async {
    final response = await _dio.get('/washers/me/verification');
    return response.data['data']['status'] as String;
  }
}
