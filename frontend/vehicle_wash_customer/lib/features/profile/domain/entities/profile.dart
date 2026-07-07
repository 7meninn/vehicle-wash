class Profile {
  final String id;
  final String fullName;
  final String mobileNumber;
  final String? email;
  final int reliabilityScore;

  Profile({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    this.email,
    required this.reliabilityScore,
  });
}
