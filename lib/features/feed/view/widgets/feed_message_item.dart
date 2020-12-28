import 'package:flutter/material.dart';
import 'package:zoom_golb/core/theme/app_colors.dart';
import 'package:zoom_golb/core/utils/extensions.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

class FeedMessageItem extends StatelessWidget {
  final UserModel user;

  final Message message;
  final bool isNews;

  const FeedMessageItem({Key key, this.user, this.message, this.isNews = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: isNews ? null : 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border:
            Border.all(color: isNews ? AppColors.primary : AppColors.secundary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message.createdAt.toBrazilian(),
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      child: ClipOval(child: _photoOrInitials()),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      user?.name ?? '',
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
                  message?.content ?? '',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _photoOrInitials() {
    String initial = 'xD';
    if (user?.name != null && user.name.length > 1) {
      initial = user.name.substring(0, 2);
    }

    Text textWidget = Text(initial,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ));

    if (user?.profilePicture != null)
      return Image.network(
        user?.profilePicture,
        loadingBuilder: (context, child, loadingProcess) {
          Semantics imageSemantics = child;
          if (loadingProcess != null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (imageSemantics.child is RawImage &&
              (imageSemantics.child as RawImage).image == null) {
            return textWidget;
          }
          return child;
        },
      );

    return textWidget;
  }
}
