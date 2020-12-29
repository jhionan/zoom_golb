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
    this.id,
    this.createdAt,
  });

  final UserModel user;
  final Message message;
  final String id;
  final DateTime createdAt;

  factory PostModel.fromJson(Map<String, Object> json) =>
      _$PostModelFromJson(json);
  Map<String, Object> toJson() => _$PostModelToJson(this);

  PostModel copyWith({
    UserModel user,
    Message message,
    String id,
    DateTime createdAt,
  }) {
    return PostModel(
      user: user ?? this.user,
      message: message ?? this.message,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

@JsonSerializable()
class Message {
  Message({
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Message.fromJson(Map<String, Object> json) => _$MessageFromJson(json);
  Map<String, Object> toJson() => _$MessageToJson(this);

  Message copyWith({
    String content,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return Message(
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
