import 'package:json_annotation/json_annotation.dart';

part 'api_config_model.g.dart';

@JsonSerializable()
class ApiConfigModel {
  String baseNews;
  String baseDummy;
  @JsonKey(name: "app-id")
  String appId;
  ApiConfigModel({
    this.baseNews,
    this.baseDummy,
    this.appId,
  });

  factory ApiConfigModel.fromJson(Map<String, Object> json) =>
      _$ApiConfigModelFromJson(json);
  Map<String, Object> toJson() => _$ApiConfigModelToJson(this);
}
