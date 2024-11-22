import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'photo_model.dart';
import 'photo_repository.dart';

final photoNotifierProvider =
    StateNotifierProvider<PhotoNotifier, AsyncValue<List<PhotoModel>>>((ref) {
  final repository = ref.watch(photoRepositoryProvider);
  return PhotoNotifier(repository);
});

class PhotoNotifier extends StateNotifier<AsyncValue<List<PhotoModel>>> {
  final PhotoRepository _repository;
  int _page = 1;
  final int _limit = 20;

  PhotoNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> fetchPhotos() async {
    try {
      final photos = await _repository.fetchPhotos(_page, _limit);
      _page++;
      state = AsyncValue.data([...state.value ?? [], ...photos]);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e,stackTrace);
    }
  
  }
}