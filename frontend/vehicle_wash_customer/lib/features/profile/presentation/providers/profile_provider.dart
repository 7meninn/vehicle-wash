import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';

import '../../data/datasources/profile_remote_datasource.dart';
import '../../data/repository_impl/profile_repository_impl.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((ref) {
  return ProfileRemoteDataSource(ref.watch(apiClientProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.watch(profileRemoteDataSourceProvider));
});

final getProfileUseCaseProvider = Provider<GetProfileUseCase>((ref) {
  return GetProfileUseCase(ref.watch(profileRepositoryProvider));
});

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  return UpdateProfileUseCase(ref.watch(profileRepositoryProvider));
});

final profileProvider = AsyncNotifierProvider<ProfileNotifier, Profile>(() {
  return ProfileNotifier();
});

class ProfileNotifier extends AsyncNotifier<Profile> {
  @override
  Future<Profile> build() async {
    return ref.watch(getProfileUseCaseProvider).execute();
  }

  Future<void> updateProfile(String fullName, String? email) async {
    state = const AsyncValue.loading();
    try {
      final updatedProfile = await ref.read(updateProfileUseCaseProvider).execute(fullName, email);
      state = AsyncValue.data(updatedProfile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
