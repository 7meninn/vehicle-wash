import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Profile> execute() {
    return _repository.getProfile();
  }
}
