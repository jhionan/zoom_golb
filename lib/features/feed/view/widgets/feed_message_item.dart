import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_golb/core/navigation/app_routes.dart';
import 'package:zoom_golb/core/theme/app_colors.dart';
import 'package:zoom_golb/core/utils/extensions.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_provider.dart';
import 'package:zoom_golb/features/feed/feed_posts/view/feed_new_post.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';
import 'package:zoom_golb/features/feed/view/widgets/circular_avatar.dart';

class FeedMessageItem extends StatelessWidget {
  final bool owner;
  final PostModel post;

  final bool isNews;

  const FeedMessageItem({
    Key key,
    this.post,
    this.isNews = true,
    this.owner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: isNews ? null : 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border:
            Border.all(color: isNews ? AppColors.primary : AppColors.secundary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                post.message.createdAt.toBrazilian(),
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                width: 48,
                child: owner
                    ? IconButton(
                        icon: Icon(
                          Icons.edit_sharp,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.newPost,
                            arguments: FeedNewPostArgs(
                                bloc: context.read(FeedPostProvider.feedPost),
                                post: post),
                          );
                        },
                      )
                    : null,
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircularAvatar(
                      user: post.user,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      post?.user?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  post?.message?.content ?? '',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
