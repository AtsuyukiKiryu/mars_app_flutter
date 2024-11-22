import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'photo_model.dart';

part 'photo_service.g.dart';

@RestApi(baseUrl: "https://android-kotlin-fun-mars-server.appspot.com/")
abstract class PhotoService {
  factory PhotoService(Dio dio, {String baseUrl}) = _PhotoService;

  @GET("/photos")
  Future<List<PhotoModel>> getPhotos(
  //   {
  //   // @Query("page") required int page,
  //   // @Query("limit") required int limit,
  // }
  );
}
