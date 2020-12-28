import 'package:dio/dio.dart';
import 'package:zoom_golb/core/api/api_config_model.dart';
export 'package:dio/dio.dart';

typedef ApiFactoryDelegate = Future<BaseApi> Function();

class BaseApi {
  BaseApi(this._apiconfig) {
    baseUrls = {
      ApiServices.dummy: _apiconfig.baseDummy,
      ApiServices.news: _apiconfig.baseNews
    };
    dummyHeader = {'_app-id': _apiconfig.appId};
  }

  final ApiConfigModel _apiconfig;
  static Map<ApiServices, String> baseUrls;
  static Map<String, String> dummyHeader;
}

enum ApiServices { dummy, news }

mixin Api {
  Dio _dio = Dio();
  Dio get dummyApi {
    _dio.options.headers = BaseApi.dummyHeader;
    _dio.options.baseUrl = BaseApi.baseUrls[ApiServices.dummy];
    return _dio;
  }

  Dio get newsApi {
    _dio.options.baseUrl = BaseApi.baseUrls[ApiServices.news];
    return _dio;
  }
}
