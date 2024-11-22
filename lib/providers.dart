import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'api_service.dart';
import 'photo.dart';

// Dio プロバイダ
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.headers["Content-Type"] = "application/json";
  return dio;
});

// ApiService プロバイダ
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

// Photos プロバイダ
final photosProvider = FutureProvider<List<Photo>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getPhotos(); // 修正済みメソッドを使用
});
