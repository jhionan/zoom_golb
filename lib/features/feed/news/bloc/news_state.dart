import 'package:flutter/foundation.dart';

import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/feed/news/data/news_model.dart';

class NewsState extends BaseState {}

class NewsStateFetched extends NewsState {
  final List<NewsModel> news;

  NewsStateFetched(this.news);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NewsStateFetched && listEquals(o.news, news);
  }

  @override
  int get hashCode => news.hashCode;
}
