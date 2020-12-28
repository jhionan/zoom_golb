import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/feed/news/bloc/news_event.dart';
import 'package:zoom_golb/features/feed/news/bloc/news_state.dart';
import 'package:zoom_golb/features/feed/news/data/news_datasource.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsDataSource _dataSource;

  NewsBloc(this._dataSource) {
    _fetch();
  }

  @override
  dispose() {
    print('DISPOSED');
    super.dispose();
  }

  @override
  onData(NewsEvent event) {
    // TODO: implement onData
  }

  _fetch() {
    _dataSource.fetchNews().listen((newsList) {
      stateController.add(NewsStateFetched(newsList));
    });
  }
}
