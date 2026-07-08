import '../repositories/dispute_repository.dart';

class UploadDisputeEvidenceUseCase {
  final DisputeRepository _repository;

  UploadDisputeEvidenceUseCase(this._repository);

  Future<void> call(String disputeId, String filePath) {
    return _repository.uploadEvidence(disputeId, filePath);
  }
}