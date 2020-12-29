import 'package:flutter/material.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/feed/news/bloc/news_event.dart';
import 'package:zoom_golb/features/feed/news/bloc/news_state.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';
import 'package:zoom_golb/features/feed/view/widgets/feed_message_item.dart';

class News extends StatelessWidget {
  final BaseBloc<NewsEvent, NewsState> bloc;

  const News({
    Key key,
    @required this.bloc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: StreamBuilder<NewsState>(
          stream: bloc.state$,
          builder: (context, snapshot) {
            List<PostModel> posts = [];
            if (snapshot.hasData && snapshot.data is NewsStateFetched) {
              NewsStateFetched state = snapshot.data;
              posts = state.news;
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 24),
              itemBuilder: (context, index) {
                return FeedMessageItem(
                  post: posts[index],
                );
              },
              itemCount: posts.length,
              separatorBuilder: (_, __) => SizedBox(
                height: 8,
              ),
            );
          }),
    );
  }
}
