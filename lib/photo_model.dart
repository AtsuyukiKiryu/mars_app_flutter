import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel {
  final String id; // ID（APIレスポンスに応じて変更）
  
  @JsonKey(name: 'img_src')
  final String url; // 画像のURL

  PhotoModel({
    required this.id,
    required this.url,
  });

  // JSONからモデルへの変換
  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  // モデルからJSONへの変換
  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}

