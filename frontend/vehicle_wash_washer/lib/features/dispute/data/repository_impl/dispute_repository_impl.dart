import 'dart:io';
import '../../domain/repositories/dispute_repository.dart';
import '../datasources/dispute_remote_datasource.dart';
import '../models/dispute_model.dart';

class DisputeRepositoryImpl implements DisputeRepository {
  final DisputeRemoteDataSource remoteDataSource;

  DisputeRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> raiseDispute(String bookingId, String type, String description) {
    return remoteDataSource.raiseDispute(bookingId, type, description);
  }

  @override
  Future<DisputeModel> getDispute(String disputeId) {
    return remoteDataSource.getDispute(disputeId);
  }

  @override
  Future<void> uploadEvidence(String disputeId, File file, String documentType) {
    return remoteDataSource.uploadEvidence(disputeId, file, documentType);
  }
}
