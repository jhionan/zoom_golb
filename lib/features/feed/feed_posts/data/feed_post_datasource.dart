import 'package:zoom_golb/features/feed/feed_posts/data/feed_post_api.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

class FeedPostDatasource {
  final FeedPostApi _api;

  FeedPostDatasource(this._api);

  Stream<List<PostModel>> fetchPosts([int page]) async* {
    yield* _api.fetchFakePosts();
  }
}
