import 'package:dio/dio.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';

class DisputeRemoteDataSource {
  final ApiClient _apiClient;

  DisputeRemoteDataSource(this._apiClient);

  Future<void> createDispute(String bookingId, Map<String, dynamic> data) async {
    await _apiClient.dio.post('/bookings/\/dispute', data: data);
  }

  Future<Map<String, dynamic>> getDispute(String disputeId) async {
    final response = await _apiClient.dio.get('/disputes/');
    return response.data;
  }

  Future<void> uploadEvidence(String disputeId, String filePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'documentType': 'PHOTO',
    });
    await _apiClient.dio.post('/disputes/\/media', data: formData);
  }
}