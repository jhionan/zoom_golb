import 'package:zoom_golb/core/base_bloc/base_bloc.dart';

class FeedPostEvent extends BaseEvent {}

class FeedPostEventAddPost extends FeedPostEvent {
  final String message;

  FeedPostEventAddPost(this.message);
}
