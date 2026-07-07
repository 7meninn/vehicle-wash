import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required super.id,
    required super.fullName,
    required super.mobileNumber,
    super.email,
    required super.reliabilityScore,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      email: json['email'] as String?,
      reliabilityScore: json['reliabilityScore'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'email': email,
      'reliabilityScore': reliabilityScore,
    };
  }

  factory ProfileModel.fromEntity(Profile profile) {
    return ProfileModel(
      id: profile.id,
      fullName: profile.fullName,
      mobileNumber: profile.mobileNumber,
      email: profile.email,
      reliabilityScore: profile.reliabilityScore,
    );
  }
}
