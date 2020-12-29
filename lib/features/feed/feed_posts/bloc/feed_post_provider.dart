import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_golb/core/db/db.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_bloc.dart';
import 'package:zoom_golb/features/feed/feed_posts/data/feed_post_api.dart';
import 'package:zoom_golb/features/feed/feed_posts/data/feed_post_datasource.dart';

class FeedPostProvider {
  FeedPostProvider._();
  static final feedPost = Provider.autoDispose<FeedPostBloc>((ref) {
    FeedPostBloc _bloc = FeedPostBloc(
        FeedPostDatasource(FeedPostApiImp(), ref.read(DbProvider.db)));
    ref.onDispose(() {
      _bloc.dispose();
    });
    return _bloc;
  });
}
