import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../data/service_area_repository.dart';
import '../domain/service_area.dart';

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final serviceAreaRepositoryProvider = Provider<ServiceAreaRepository>((ref) {
  final client = ref.watch(httpClientProvider);
  return ServiceAreaRepository(client);
});

final allServiceAreasProvider = FutureProvider<List<ServiceArea>>((ref) async {
  final repo = ref.watch(serviceAreaRepositoryProvider);
  return repo.getAllServiceAreas();
});

class SelectedServiceAreasNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final ServiceAreaRepository _repository;

  SelectedServiceAreasNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadMyServiceAreas();
  }

  Future<void> _loadMyServiceAreas() async {
    try {
      final ids = await _repository.getMyServiceAreaIds();
      state = AsyncValue.data(ids);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void toggleSelection(String id) {
    if (state is AsyncData) {
      final current = state.value!;
      if (current.contains(id)) {
        state = AsyncValue.data(current.where((e) => e != id).toList());
      } else {
        state = AsyncValue.data([...current, id]);
      }
    }
  }

  Future<void> saveSelections() async {
    if (state is AsyncData) {
      final current = state.value!;
      await _repository.updateServiceAreas(current);
    }
  }
}

final selectedServiceAreasProvider = StateNotifierProvider<SelectedServiceAreasNotifier, AsyncValue<List<String>>>((ref) {
  final repo = ref.watch(serviceAreaRepositoryProvider);
  return SelectedServiceAreasNotifier(repo);
});
