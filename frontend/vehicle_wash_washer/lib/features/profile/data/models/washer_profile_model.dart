import '../../domain/entities/washer_profile.dart';

class WasherProfileModel extends WasherProfile {
  WasherProfileModel({
    required super.id,
    required super.fullName,
    required super.mobileNumber,
    required super.verificationStatus,
    required super.averageRating,
    required super.trustScore,
    required super.totalCompletedJobs,
    required HomeBaseModel super.homeBase,
  });

  factory WasherProfileModel.fromJson(Map<String, dynamic> json) {
    return WasherProfileModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      mobileNumber: json['mobileNumber'] as String,
      verificationStatus: json['verificationStatus'] as String,
      averageRating: (json['averageRating'] as num).toDouble(),
      trustScore: (json['trustScore'] as num).toDouble(),
      totalCompletedJobs: json['totalCompletedJobs'] as int,
      homeBase: HomeBaseModel.fromJson(json['homeBase'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'verificationStatus': verificationStatus,
      'averageRating': averageRating,
      'trustScore': trustScore,
      'totalCompletedJobs': totalCompletedJobs,
      'homeBase': (homeBase as HomeBaseModel).toJson(),
    };
  }
}

class HomeBaseModel extends HomeBase {
  HomeBaseModel({
    required super.address,
    required super.latitude,
    required super.longitude,
  });

  factory HomeBaseModel.fromJson(Map<String, dynamic> json) {
    return HomeBaseModel(
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
