class DisputeEvidenceEntity {
  final String id;
  final String fileUrl;
  final String uploadedBy;

  DisputeEvidenceEntity({required this.id, required this.fileUrl, required this.uploadedBy});
}

class DisputeEntity {
  final String id;
  final String bookingId;
  final String disputeType;
  final String disputeStatus;
  final String issueDescription;
  final String? adminResolution;
  final String? resolutionType;
  final double? refundPercentage;
  final double? payoutPercentage;
  final List<DisputeEvidenceEntity> evidenceList;

  DisputeEntity({
    required this.id,
    required this.bookingId,
    required this.disputeType,
    required this.disputeStatus,
    required this.issueDescription,
    this.adminResolution,
    this.resolutionType,
    this.refundPercentage,
    this.payoutPercentage,
    required this.evidenceList,
  });
}