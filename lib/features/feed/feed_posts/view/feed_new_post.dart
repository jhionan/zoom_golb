import 'package:flutter/material.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/core/theme/app_colors.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_event.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_state.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';
import 'package:zoom_golb/features/feed/view/widgets/circular_avatar.dart';
import 'package:zoom_golb/core/utils/extensions.dart';

class FeedNewPosts extends StatefulWidget {
  final BaseBloc<FeedPostEvent, FeedPostState> bloc;
  final PostModel post;
  final UserModel user;

  const FeedNewPosts({Key key, @required this.bloc, this.post, this.user})
      : super(key: key);

  @override
  _FeedNewPostsState createState() => _FeedNewPostsState();
}

class _FeedNewPostsState extends State<FeedNewPosts> {
  TextEditingController _messageController;

  @override
  void initState() {
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 24),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(widget.post != null)
            Align(
              alignment: Alignment.topRight,
              child: Text(widget.post.message.createdAt.toBrazilian()),
            ),
            Row(
              children: [
                SizedBox(
                  width: 36,
                  child: Column(
                    children: [
                      CircularAvatar(
                        user: widget.user,
                        radius: 16,
                      ),
                      Text(widget?.user?.name ?? 'Guest',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black
                      ),)
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: TextField(
                    controller: _messageController,
                    maxLines: null,
                    maxLength: 280,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      hintText: 'O que esta acontecendo?',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
            MaterialButton(
              onPressed: _submit,
              child: Text('ENVIAR'),
              color: AppColors.accent,
            )
          ],
        ),
      ),
    );
  }

  _submit() {
    widget.bloc.inEvent.add(FeedPostEventAddPost(_messageController.text));
  }
}
