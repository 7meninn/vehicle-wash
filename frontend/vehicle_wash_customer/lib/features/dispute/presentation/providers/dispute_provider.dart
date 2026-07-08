import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../../data/datasources/dispute_remote_datasource.dart';
import '../../data/repository_impl/dispute_repository_impl.dart';
import '../../domain/usecases/create_dispute_usecase.dart';
import '../../domain/usecases/get_dispute_usecase.dart';
import '../../domain/usecases/upload_dispute_evidence_usecase.dart';
import '../../domain/entities/dispute_entity.dart';

final disputeRemoteDataSourceProvider = Provider<DisputeRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DisputeRemoteDataSource(apiClient);
});

final disputeRepositoryProvider = Provider<DisputeRepositoryImpl>((ref) {
  final dataSource = ref.watch(disputeRemoteDataSourceProvider);
  return DisputeRepositoryImpl(dataSource);
});

final createDisputeUseCaseProvider = Provider<CreateDisputeUseCase>((ref) {
  return CreateDisputeUseCase(ref.watch(disputeRepositoryProvider));
});

final getDisputeUseCaseProvider = Provider<GetDisputeUseCase>((ref) {
  return GetDisputeUseCase(ref.watch(disputeRepositoryProvider));
});

final uploadDisputeEvidenceUseCaseProvider = Provider<UploadDisputeEvidenceUseCase>((ref) {
  return UploadDisputeEvidenceUseCase(ref.watch(disputeRepositoryProvider));
});

final disputeDetailProvider = FutureProvider.family<DisputeEntity, String>((ref, disputeId) {
  final useCase = ref.watch(getDisputeUseCaseProvider);
  return useCase(disputeId);
});