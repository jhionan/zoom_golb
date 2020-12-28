import 'package:zoom_golb/features/feed/news/data/news_api.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

class NewsDataSource {
  final NewsApi _newsApi;

  NewsDataSource(this._newsApi);

  Stream<List<PostModel>> fetchNews() async* {
    yield* _newsApi.getNews();
  }
}
