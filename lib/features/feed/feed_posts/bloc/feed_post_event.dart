import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

class FeedPostEvent extends BaseEvent {}

class FeedPostEventAddPost extends FeedPostEvent {
  final PostModel post;
  final Function success;

  FeedPostEventAddPost(this.post, this.success);
}
