import '../entities/washer_profile.dart';

abstract class ProfileRepository {
  Future<WasherProfile> getProfile();
  Future<void> updateProfile({required String fullName});
  Future<String> getVerificationStatus();
}
