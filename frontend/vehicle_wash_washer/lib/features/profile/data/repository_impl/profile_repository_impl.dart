import '../../domain/entities/washer_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<WasherProfile> getProfile() async {
    return await _remoteDataSource.getProfile();
  }

  @override
  Future<void> updateProfile({required String fullName}) async {
    return await _remoteDataSource.updateProfile(fullName: fullName);
  }

  @override
  Future<String> getVerificationStatus() async {
    return await _remoteDataSource.getVerificationStatus();
  }
}
