import '../entities/dispute_entity.dart';

abstract class DisputeRepository {
  Future<void> createDispute(String bookingId, String type, String description);
  Future<DisputeEntity> getDispute(String disputeId);
  Future<void> uploadEvidence(String disputeId, String filePath);
}