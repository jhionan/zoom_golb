import 'package:flutter/material.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_event.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_state.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';
import 'package:zoom_golb/features/feed/view/widgets/feed_message_item.dart';

class FeedPosts extends StatelessWidget {
  final BaseBloc<FeedPostEvent, FeedPostState> bloc;

  const FeedPosts({Key key, @required this.bloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: StreamBuilder<FeedPostState>(
          stream: bloc.state$,
          builder: (context, snapshot) {
            List<PostModel> news = [];
            if (snapshot.hasData && snapshot.data is FeedPostStateFetched) {
              FeedPostStateFetched state = snapshot.data;
              news = state.posts;
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 24),
              itemBuilder: (context, index) {
                return FeedMessageItem(
                  message: news[index].message,
                  user: news[index].user,
                  isNews: false,
                );
              },
              itemCount: news.length,
              separatorBuilder: (_, __) => SizedBox(
                height: 8,
              ),
            );
          }),
    );
  }
}
