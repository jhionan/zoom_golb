import 'package:rxdart/rxdart.dart';
import 'package:zoom_golb/core/db/db.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';
import 'package:zoom_golb/features/feed/feed_posts/data/feed_post_api.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

class FeedPostDatasource {
  final FeedPostApi _api;
  final Db _db;

  FeedPostDatasource(this._api, this._db);

  Future<UserModel> get user async => await _db.getUser();

  Stream<List<PostModel>> fetchPosts([int page]) async* {
   yield*  Rx.combineLatest2<List<PostModel>, List<PostModel>, List<PostModel>>(
        _api.fetchPosts(), _api.fetchFakePosts(), (posts, fakePosts) {
      if (posts.length < 5) {
        posts.addAll(fakePosts);
      }
      return posts;
    });

    //yield* _api.fetchFakePosts();
  }

  void addPost(PostModel post) {
    _api.addPost(post);
  }
}
