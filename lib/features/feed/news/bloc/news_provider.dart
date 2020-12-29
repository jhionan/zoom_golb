import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_golb/features/feed/news/bloc/news_bloc.dart';
import 'package:zoom_golb/features/feed/news/data/news_api.dart';
import 'package:zoom_golb/features/feed/news/data/news_datasource.dart';

class NewsProvider {
  NewsProvider._();

  static final newsBloc = Provider.autoDispose<NewsBloc>((ref) {
    NewsBloc _bloc = NewsBloc(NewsDataSource(NewsApiImp()));
    ref.onDispose(() {
      _bloc.dispose();
    });
    return _bloc;
  });
}
