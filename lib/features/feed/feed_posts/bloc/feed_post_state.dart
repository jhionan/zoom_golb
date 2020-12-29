import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

class FeedPostState extends BaseState {}

class FeedPostStateFetched extends FeedPostState {
  final List<PostModel> posts;
  final UserModel user;

  FeedPostStateFetched({this.posts, this.user});
}
