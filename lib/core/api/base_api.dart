import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zoom_golb/core/api/api_config_model.dart';

typedef ApiFactoryDelegate = Future<BaseApi> Function();

class BaseApi {
  BaseApi(this._apiconfig) {
    _dio = Dio();
    _dio.options.baseUrl = _apiconfig.baseNews;
    ready.add(true);
  }

  final ApiConfigModel _apiconfig;
  Dio _dio;
  static BehaviorSubject<bool> ready = BehaviorSubject.seeded(false);

  dispose() {
    ready.close();
  }

  Dio get instance => _dio;
}

mixin Api {}
