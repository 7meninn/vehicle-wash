import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../../data/datasources/profile_remote_datasource.dart';
import '../../data/repository_impl/profile_repository_impl.dart';
import '../../domain/entities/washer_profile.dart';
import '../../domain/repositories/profile_repository.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProfileRemoteDataSource(apiClient.dio);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteDataSource = ref.watch(profileRemoteDataSourceProvider);
  return ProfileRepositoryImpl(remoteDataSource);
});

final profileProvider = FutureProvider<WasherProfile>((ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getProfile();
});
