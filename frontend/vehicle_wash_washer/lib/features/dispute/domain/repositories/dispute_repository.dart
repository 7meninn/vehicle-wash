import 'dart:io';
import '../../data/models/dispute_model.dart';

abstract class DisputeRepository {
  Future<void> raiseDispute(String bookingId, String type, String description);
  Future<DisputeModel> getDispute(String disputeId);
  Future<void> uploadEvidence(String disputeId, File file, String documentType);
}
