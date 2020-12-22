import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/splash/bloc/splash_events.dart';
import 'package:zoom_golb/features/splash/data/splash_datasource.dart';
import 'package:meta/meta.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashDatasource _datasource;
  SplashBloc({
    @required SplashDatasource datasource,
  }) : this._datasource = datasource {
    _initAppDependences();
  }
  @override
  onData(SplashEvent event) {
    // TODO: implement onData
    throw UnimplementedError();
  }

  _initAppDependences() {
    _datasource.init().listen((event) {
      print('Loaded app $event');
    }, onError: _onError);
  }

  _onError(Object error, StackTrace stack) {}
}
