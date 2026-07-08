import '../../domain/entities/dispute_entity.dart';

class DisputeEvidenceModel extends DisputeEvidenceEntity {
  DisputeEvidenceModel({
    required super.id,
    required super.fileUrl,
    required super.uploadedBy,
  });

  factory DisputeEvidenceModel.fromJson(Map<String, dynamic> json) {
    return DisputeEvidenceModel(
      id: json['id'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      uploadedBy: json['uploadedBy'] ?? '',
    );
  }
}

class DisputeModel extends DisputeEntity {
  DisputeModel({
    required super.id,
    required super.bookingId,
    required super.disputeType,
    required super.disputeStatus,
    required super.issueDescription,
    super.adminResolution,
    super.resolutionType,
    super.refundPercentage,
    super.payoutPercentage,
    required super.evidenceList,
  });

  factory DisputeModel.fromJson(Map<String, dynamic> json) {
    final evidenceList = (json['evidenceList'] as List? ?? [])
        .map((e) => DisputeEvidenceModel.fromJson(e))
        .toList();

    return DisputeModel(
      id: json['id'] ?? '',
      bookingId: json['bookingId'] ?? '',
      disputeType: json['disputeType'] ?? '',
      disputeStatus: json['disputeStatus'] ?? '',
      issueDescription: json['issueDescription'] ?? '',
      adminResolution: json['adminResolution'],
      resolutionType: json['resolutionType'],
      refundPercentage: (json['refundPercentage'] as num?)?.toDouble(),
      payoutPercentage: (json['payoutPercentage'] as num?)?.toDouble(),
      evidenceList: evidenceList,
    );
  }
}