import 'package:flutter/material.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_event.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_state.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

class FeedNewPosts extends StatelessWidget {
  final BaseBloc<FeedPostEvent, FeedPostState> bloc;
  final PostModel post;

  const FeedNewPosts({Key key, @required this.bloc, this.post})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    );
  }
}
