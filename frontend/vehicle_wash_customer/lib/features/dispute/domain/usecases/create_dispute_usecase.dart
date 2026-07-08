import '../repositories/dispute_repository.dart';

class CreateDisputeUseCase {
  final DisputeRepository _repository;

  CreateDisputeUseCase(this._repository);

  Future<void> call(String bookingId, String type, String description) {
    return _repository.createDispute(bookingId, type, description);
  }
}