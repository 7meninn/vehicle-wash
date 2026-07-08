class DisputeEvidenceModel {
  final String id;
  final String uploadedBy;
  final String mediaType;
  final String storageKey;
  final DateTime uploadedAt;

  DisputeEvidenceModel({
    required this.id,
    required this.uploadedBy,
    required this.mediaType,
    required this.storageKey,
    required this.uploadedAt,
  });

  factory DisputeEvidenceModel.fromJson(Map<String, dynamic> json) {
    return DisputeEvidenceModel(
      id: json['id'] ?? '',
      uploadedBy: json['uploadedBy'] ?? '',
      mediaType: json['mediaType'] ?? '',
      storageKey: json['storageKey'] ?? '',
      uploadedAt: json['uploadedAt'] != null ? DateTime.parse(json['uploadedAt']) : DateTime.now(),
    );
  }
}

class DisputeModel {
  final String id;
  final String bookingId;
  final String disputeType;
  final String raisedBy;
  final String disputeStatus;
  final String issueDescription;
  final String? adminResolution;
  final String? resolutionType;
  final double? refundPercentage;
  final double? payoutPercentage;
  final String? resolvedBy;
  final DateTime? resolvedAt;
  final DateTime createdAt;
  final List<DisputeEvidenceModel> evidenceList;

  DisputeModel({
    required this.id,
    required this.bookingId,
    required this.disputeType,
    required this.raisedBy,
    required this.disputeStatus,
    required this.issueDescription,
    this.adminResolution,
    this.resolutionType,
    this.refundPercentage,
    this.payoutPercentage,
    this.resolvedBy,
    this.resolvedAt,
    required this.createdAt,
    required this.evidenceList,
  });

  factory DisputeModel.fromJson(Map<String, dynamic> json) {
    var evidenceJson = json['evidenceList'] as List?;
    List<DisputeEvidenceModel> evidenceList = evidenceJson != null 
        ? evidenceJson.map((e) => DisputeEvidenceModel.fromJson(e)).toList() 
        : [];

    return DisputeModel(
      id: json['id'] ?? '',
      bookingId: json['bookingId'] ?? '',
      disputeType: json['disputeType'] ?? '',
      raisedBy: json['raisedBy'] ?? '',
      disputeStatus: json['disputeStatus'] ?? '',
      issueDescription: json['issueDescription'] ?? '',
      adminResolution: json['adminResolution'],
      resolutionType: json['resolutionType'],
      refundPercentage: json['refundPercentage']?.toDouble(),
      payoutPercentage: json['payoutPercentage']?.toDouble(),
      resolvedBy: json['resolvedBy'],
      resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      evidenceList: evidenceList,
    );
  }
}
