import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Profile> getProfile() async {
    return await _remoteDataSource.getProfile();
  }

  @override
  Future<Profile> updateProfile(String fullName, String? email) async {
    return await _remoteDataSource.updateProfile(fullName, email);
  }
}
