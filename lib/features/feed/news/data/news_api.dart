import 'package:zoom_golb/core/api/base_api.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

abstract class NewsApi {
  Stream<List<NewsModel>> getNews();
}

class NewsApiImp with Api implements NewsApi {
  @override
  Stream<List<NewsModel>> getNews() async* {
    Response response = await newsApi.get('data.json');
    if (response != null &&
        response.statusCode > 199 &&
        response.statusCode < 300 &&
        response.data != null) {
      NewsApiModel data = NewsApiModel.fromJson(response.data);
      yield data.news;
      return;
    }
    yield response.data;
  }
}
