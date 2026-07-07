import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../models/profile_model.dart';

class ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSource(this._apiClient);

  Future<ProfileModel> getProfile() async {
    final response = await _apiClient.dio.get('/customers/me');
    // Ensure we parse the standard response format properly
    // The response body is typically { "success": true, "data": { ... } }
    final data = response.data['data'] ?? response.data;
    return ProfileModel.fromJson(data);
  }

  Future<ProfileModel> updateProfile(String fullName, String? email) async {
    final response = await _apiClient.dio.put('/customers/me', data: {
      'fullName': fullName,
      if (email != null && email.isNotEmpty) 'email': email,
    });
    final data = response.data['data'] ?? response.data;
    return ProfileModel.fromJson(data);
  }
}
