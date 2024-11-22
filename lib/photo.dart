import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  final String id;
  @JsonKey(name: 'img_src')
  final String imgSrc;

  Photo({
    required this.id,
    required this.imgSrc,
  });

  // JSON からクラスを生成
  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  // クラスを JSON に変換
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
