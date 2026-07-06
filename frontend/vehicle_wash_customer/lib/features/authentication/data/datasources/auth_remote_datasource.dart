import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';

class AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSource(this._apiClient);

  Future<bool> requestOtp(String mobileNumber) async {
    final response = await _apiClient.requestOtp(mobileNumber);
    return response.statusCode == 200;
  }

  Future<Map<String, dynamic>> verifyOtp(String mobileNumber, String otp) async {
    final response = await _apiClient.verifyOtp(mobileNumber, otp);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Invalid OTP');
    }
  }
}
