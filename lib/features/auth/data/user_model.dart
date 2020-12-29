import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String email;
  final String profilePicture;
  final String id;
  UserModel({
    this.name,
    this.email,
    this.profilePicture,
    this.id,
  });

  factory UserModel.fromJson(Map<String, Object> json) =>
      _$UserModelFromJson(json);
  Map<String, Object> toJson() => _$UserModelToJson(this);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.name == name &&
        o.email == email &&
        o.profilePicture == profilePicture &&
        o.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        profilePicture.hashCode ^
        id.hashCode;
  }
}
