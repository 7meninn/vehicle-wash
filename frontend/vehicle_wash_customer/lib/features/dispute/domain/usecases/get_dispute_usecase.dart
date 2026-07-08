import '../entities/dispute_entity.dart';
import '../repositories/dispute_repository.dart';

class GetDisputeUseCase {
  final DisputeRepository _repository;

  GetDisputeUseCase(this._repository);

  Future<DisputeEntity> call(String disputeId) {
    return _repository.getDispute(disputeId);
  }
}