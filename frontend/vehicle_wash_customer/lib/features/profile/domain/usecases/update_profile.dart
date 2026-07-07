import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<Profile> execute(String fullName, String? email) {
    return _repository.updateProfile(fullName, email);
  }
}
