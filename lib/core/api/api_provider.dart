import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';


import 'package:meta/meta.dart';
import 'package:zoom_golb/core/api/api_config_model.dart';
import 'package:zoom_golb/core/api/base_api.dart';

@visibleForTesting
final apiConfigProvider = FutureProvider<ApiConfigModel>((ref) async {
  final Map<String, Object> content = json.decode(
    await rootBundle.loadString('assets/configuration/api_config.json'),
  );
  return ApiConfigModel.fromJson(content);
});

final apiProvider = FutureProvider<BaseApi>((ref) async {
  ApiConfigModel config = await ref.watch(apiConfigProvider.future);
  return BaseApi(config);
});
