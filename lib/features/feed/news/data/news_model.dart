import 'package:json_annotation/json_annotation.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsApiModel {
  NewsApiModel({
    this.news,
  });

  final List<PostModel> news;

  factory NewsApiModel.fromJson(Map<String, Object> json) =>
      _$NewsApiModelFromJson(json);
  Map<String, Object> toJson() => _$NewsApiModelToJson(this);
}

@JsonSerializable()
class PostModel {
  PostModel({
    this.user,
    this.message,
  });

  final UserModel user;
  final Message message;

  factory PostModel.fromJson(Map<String, Object> json) => _$PostModelFromJson(json);
  Map<String, Object> toJson() => _$PostModelToJson(this);
}

@JsonSerializable()
class Message {
  Message({
    this.content,
    this.createdAt,
  });

  final String content;
  final DateTime createdAt;

  factory Message.fromJson(Map<String, Object> json) => _$MessageFromJson(json);
  Map<String, Object> toJson() => _$MessageToJson(this);
}
