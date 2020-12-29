import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_golb/core/navigation/app_routes.dart';
import 'package:zoom_golb/core/theme/app_colors.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_provider.dart';
import 'package:zoom_golb/features/feed/feed_posts/view/feed_new_post.dart';
import 'package:zoom_golb/features/feed/feed_posts/view/feed_posts.dart';
import 'package:zoom_golb/features/feed/news/bloc/news_provider.dart';
import 'package:zoom_golb/features/feed/news/view/news.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int activeIndex = 0;
  List<Widget> _tabList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secundary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Consumer(
        builder: (BuildContext context,
            T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
          _tabList = [
            News(
              bloc: watch(NewsProvider.newsBloc),
            ),
            FeedPosts(
              bloc: watch(FeedPostProvider.feedPost),
            ),
          ];
          return Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              activeIndex: activeIndex,
              icons: [
                Icons.fiber_new_sharp,
                Icons.scatter_plot_sharp,
              ],
              onTap: (index) {
                setState(() {
                  activeIndex = index;
                });
              },
              leftCornerRadius: 24,
              rightCornerRadius: 24,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.defaultEdge,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.transparent,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.secundary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Icon(
                  Icons.add_sharp,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.newPost,
                    arguments: FeedNewPostArgs(
                        bloc: context.read(FeedPostProvider.feedPost)));
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: SafeArea(child: _tabList[activeIndex]),
          );
        },
      ),
    );
  }
}
