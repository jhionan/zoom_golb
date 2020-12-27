import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/feed/news/bloc/news_event.dart';
import 'package:zoom_golb/features/feed/news/bloc/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  @override
  onData(NewsEvent event) {
    // TODO: implement onData
    throw UnimplementedError();
  }
}
