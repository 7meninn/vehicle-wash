class WasherProfile {
  final String id;
  final String fullName;
  final String mobileNumber;
  final String verificationStatus;
  final double averageRating;
  final double trustScore;
  final int totalCompletedJobs;
  final HomeBase homeBase;

  WasherProfile({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.verificationStatus,
    required this.averageRating,
    required this.trustScore,
    required this.totalCompletedJobs,
    required this.homeBase,
  });
}

class HomeBase {
  final String address;
  final double latitude;
  final double longitude;

  HomeBase({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}
