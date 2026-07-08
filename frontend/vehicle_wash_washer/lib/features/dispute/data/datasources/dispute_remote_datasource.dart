import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vehicle_wash_shared/core/network/api_client.dart';
import '../models/dispute_model.dart';

abstract class DisputeRemoteDataSource {
  Future<void> raiseDispute(String bookingId, String type, String description);
  Future<DisputeModel> getDispute(String disputeId);
  Future<void> uploadEvidence(String disputeId, File file, String documentType);
}

class DisputeRemoteDataSourceImpl implements DisputeRemoteDataSource {
  final ApiClient apiClient;

  DisputeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<void> raiseDispute(String bookingId, String type, String description) async {
    await apiClient.dio.post(
      '/bookings/$bookingId/dispute',
      data: {
        'type': type,
        'description': description,
      },
    );
  }

  @override
  Future<DisputeModel> getDispute(String disputeId) async {
    final response = await apiClient.dio.get('/disputes/$disputeId');
    return DisputeModel.fromJson(response.data['data']);
  }

  @override
  Future<void> uploadEvidence(String disputeId, File file, String documentType) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      'documentType': documentType,
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    await apiClient.dio.post(
      '/disputes/$disputeId/media',
      data: formData,
    );
  }
}
