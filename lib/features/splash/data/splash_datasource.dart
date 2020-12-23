import 'package:riverpod/riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zoom_golb/core/api/api_provider.dart';
import 'package:zoom_golb/core/api/base_api.dart';
import 'package:zoom_golb/core/firebase/firebase_app.dart';

abstract class SplashDatasource {
  Stream<bool> init();
}

class SplashDatasourceImp implements SplashDatasource {
  @override
  Stream<bool> init() async* {
    yield* Rx.combineLatest<bool, bool>([
      _initApi(),
      _initFirebaseApp(),
    ], (values) => values.every((element) => element));
  }

  Stream<bool> _initApi() async* {
    yield (await ProviderContainer().read(ApiProvider.apiProvider.future))
            .runtimeType ==
        BaseApi;
  }

  Stream<bool> _initFirebaseApp() async* {
    yield* ProviderContainer().read(FirebaseApp.provideFirebaseApp.stream);
  }
}
