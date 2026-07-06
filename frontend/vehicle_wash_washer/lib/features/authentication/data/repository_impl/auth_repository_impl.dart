import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<bool> requestOtp(String mobileNumber) {
    return _remoteDataSource.requestOtp(mobileNumber);
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(String mobileNumber, String otp) {
    return _remoteDataSource.verifyOtp(mobileNumber, otp);
  }
}
