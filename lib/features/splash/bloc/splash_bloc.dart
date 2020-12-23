import 'package:meta/meta.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/splash/bloc/splash_events.dart';
import 'package:zoom_golb/features/splash/data/splash_datasource.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashDatasource _datasource;

  SplashBloc({
    @required SplashDatasource datasource,
  }) : this._datasource = datasource {
    _initAppDependences();
  }

  Function success;

  @override
  onData(SplashEvent event) {
    success = event.success;
  }

  _initAppDependences() {
    _datasource.init().listen((event) {
      print('Loaded app $event');
      success();
    }, onError: _onError);
  }

  _onError(Object error, StackTrace stack) {}
}
