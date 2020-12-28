import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

class FeedPostState extends BaseState {}

class FeedPostStateFetched extends FeedPostState {
  final List<PostModel> posts;

  FeedPostStateFetched(this.posts);
}
