import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'photo.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://android-kotlin-fun-mars-server.appspot.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/photos")
  Future<String> getPhotosRaw(); // レスポンスを String 型で取得
}

// JSON をデコードし、Photo オブジェクトのリストを返す関数を追加
extension ApiServiceExtensions on ApiService {
  Future<List<Photo>> getPhotos() async {
    final rawJson = await getPhotosRaw();
    final List<dynamic> jsonList = jsonDecode(rawJson); // String を List にデコード
    return jsonList.map((json) => Photo.fromJson(json)).toList();
  }
}
