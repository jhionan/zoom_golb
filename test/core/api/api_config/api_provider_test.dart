import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:zoom_golb/core/api/api_config_model.dart';
import 'package:zoom_golb/core/api/api_provider.dart';
import 'package:zoom_golb/core/api/base_api.dart';

main() {
  test('ApiConfigModel Serialization', () {
    String apiConfigJson = '''{
    "base_news" : "https://gb-mobile-app-teste.s3.amazonaws.com/",
    "base_dummy" : "https://dummyapi.io/data/api/",
    "app-id" : "5fe109855491ba26df85ad3c" 
}''';

    expect(
        ApiConfigModel.fromJson(jsonDecode(apiConfigJson)),
        isA<ApiConfigModel>()
            .having((apiConfig) => apiConfig.baseNews, 'base news url',
                'https://gb-mobile-app-teste.s3.amazonaws.com/')
            .having((apiConfig) => apiConfig.baseDummy, 'dummy base api',
                'https://dummyapi.io/data/api/')
            .having((apiConfig) => apiConfig.appId, 'app-id',
                '5fe109855491ba26df85ad3c'));
  });
  testWidgets('create ApiConfig from json asset', (tester) async {
    final container = ProviderContainer();
    ApiConfigModel config =
        await container.read(ApiProvider.apiConfigProvider.future);
    expect(
        config,
        isA<ApiConfigModel>().having((apiConfig) => apiConfig.baseNews,
            'base news url', 'https://gb-mobile-app-teste.s3.amazonaws.com/'));

    BaseApi _api = await container.read(ApiProvider.apiProvider.future);

    expect(
        _api,
        isA<BaseApi>().having((baseApi) => BaseApi.baseUrls,
            'Base urls are not empty', isNotEmpty));
  }, timeout: Timeout(Duration(minutes: 1)));
}
