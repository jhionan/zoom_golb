import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_event.dart';
import 'package:zoom_golb/features/feed/feed_posts/bloc/feed_post_state.dart';
import 'package:zoom_golb/features/feed/feed_posts/data/feed_post_datasource.dart';

class FeedPostBloc extends Bloc<FeedPostEvent, FeedPostState> {
  final FeedPostDatasource _datasource;

  FeedPostBloc(this._datasource) {
    _fetchInitialPosts();
  }

  @override
  onData(FeedPostEvent event) {
    // TODO: implement onData
    throw UnimplementedError();
  }

  _fetchInitialPosts() {
    _datasource.fetchPosts().listen((posts) {
      stateController.add(FeedPostStateFetched(posts));
    });
  }
}
