import '../../domain/entities/dispute_entity.dart';
import '../../domain/repositories/dispute_repository.dart';
import '../datasources/dispute_remote_datasource.dart';
import '../models/dispute_model.dart';

class DisputeRepositoryImpl implements DisputeRepository {
  final DisputeRemoteDataSource _dataSource;

  DisputeRepositoryImpl(this._dataSource);

  @override
  Future<void> createDispute(String bookingId, String type, String description) async {
    await _dataSource.createDispute(bookingId, {
      'type': type,
      'description': description,
    });
  }

  @override
  Future<DisputeEntity> getDispute(String disputeId) async {
    final result = await _dataSource.getDispute(disputeId);
    return DisputeModel.fromJson(result['data'] ?? {});
  }

  @override
  Future<void> uploadEvidence(String disputeId, String filePath) async {
    await _dataSource.uploadEvidence(disputeId, filePath);
  }
}