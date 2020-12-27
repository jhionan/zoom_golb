import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String email;
  final String profilePicture;
  UserModel({
    this.name,
    this.email,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, Object> json) =>
      _$UserModelFromJson(json);
  Map<String, Object> toJson() => _$UserModelToJson(this);
}
