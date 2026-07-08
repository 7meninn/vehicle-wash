import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_shared/core/providers/core_providers.dart';
import '../../data/datasources/dispute_remote_datasource.dart';
import '../../data/repository_impl/dispute_repository_impl.dart';
import '../../domain/repositories/dispute_repository.dart';
import '../../data/models/dispute_model.dart';

final disputeRemoteDataSourceProvider = Provider<DisputeRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DisputeRemoteDataSourceImpl(apiClient);
});

final disputeRepositoryProvider = Provider<DisputeRepository>((ref) {
  final dataSource = ref.watch(disputeRemoteDataSourceProvider);
  return DisputeRepositoryImpl(dataSource);
});

final disputeDetailProvider = FutureProvider.family<DisputeModel, String>((ref, disputeId) async {
  final repository = ref.watch(disputeRepositoryProvider);
  return await repository.getDispute(disputeId);
});

class DisputeActionNotifier extends StateNotifier<AsyncValue<void>> {
  final DisputeRepository repository;

  DisputeActionNotifier(this.repository) : super(const AsyncValue.data(null));

  Future<void> raiseDispute({
    required String bookingId,
    required String type,
    required String description,
    File? evidenceFile,
  }) async {
    try {
      state = const AsyncValue.loading();
      await repository.raiseDispute(bookingId, type, description);
      
      // If evidence upload was part of the flow directly, we'd need the created dispute ID.
      // But standard flow: create dispute -> maybe upload later, or create returns ID. 
      // The API spec returns 201 Created but no body is specified.
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> uploadEvidence(String disputeId, File file, String documentType) async {
    try {
      state = const AsyncValue.loading();
      await repository.uploadEvidence(disputeId, file, documentType);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final disputeActionProvider = StateNotifierProvider.autoDispose<DisputeActionNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(disputeRepositoryProvider);
  return DisputeActionNotifier(repository);
});
