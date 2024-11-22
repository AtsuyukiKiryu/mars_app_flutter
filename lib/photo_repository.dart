import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'photo_model.dart';
import 'photo_service.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final photoServiceProvider = Provider<PhotoService>((ref) {
  final dio = ref.watch(dioProvider);
  return PhotoService(dio);
});

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  final service = ref.watch(photoServiceProvider);
  return PhotoRepository(service);
});

class PhotoRepository {
  final PhotoService _service;

  PhotoRepository(this._service);

  Future<List<PhotoModel>> fetchPhotos(int page, int limit) {
    return _service.getPhotos();
  }
}
