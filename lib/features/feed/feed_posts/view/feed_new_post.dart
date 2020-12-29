import 'package:flutter/material.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/core/theme/app_colors.dart';
import 'package:zoom_golb/core/utils/extensions.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_event.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_state.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';
import 'package:zoom_golb/features/feed/view/widgets/circular_avatar.dart';

class FeedNewPostArgs {
  final BaseBloc<FeedPostEvent, FeedPostState> bloc;
  final PostModel post;
  FeedNewPostArgs({this.bloc, this.post});
}

class FeedNewPost extends StatefulWidget {
  final FeedNewPostArgs args;

  const FeedNewPost({Key key, this.args}) : super(key: key);

  @override
  _FeedNewPostState createState() => _FeedNewPostState();
}

class _FeedNewPostState extends State<FeedNewPost> {
  TextEditingController _messageController;

  @override
  void initState() {
    String initialValue;
    if(widget.args.post != null) {
      initialValue = widget.args.post.message.content;
    }
    _messageController = TextEditingController(text: initialValue);
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdedede),
      body: Center(
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
              if (widget.args.post != null)
                Align(
                  alignment: Alignment.topRight,
                  child: Text(widget.args.post.message.createdAt.toBrazilian()),
                ),
              Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: StreamBuilder<FeedPostState>(
                        stream: widget.args.bloc.state$,
                        builder: (context, snapshot) {
                          String name = 'Guest';
                          UserModel user;
                          if (snapshot.hasData &&
                              snapshot.data is FeedPostStateFetched) {
                            FeedPostStateFetched data = snapshot.data;
                            name = data.user.name;
                            user = data.user;
                          }
                          return Column(
                            children: [
                              CircularAvatar(
                                user: user,
                                radius: 16,
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ),
                            ],
                          );
                        }),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      _submit();
                      Navigator.of(context).pop();
                    },
                    child: Text('ENVIAR'),
                    color: AppColors.accent,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _submit() {
    if (widget.args.post == null) {
      widget.args.bloc.inEvent.add(
        FeedPostEventAddPost(
          PostModel(
            message: Message(
              content: _messageController.text,
              createdAt: DateTime.now().toUtc(),
            ),
          ),
        ),
      );
    } else {
      widget.args.bloc.inEvent.add(
        FeedPostEventAddPost(
          widget.args.post.copyWith(
            message: widget.args.post.message.copyWith(
              content: _messageController.text,
              updatedAt: DateTime.now().toUtc(),
            ),
          ),
        ),
      );
    }
  }
}
