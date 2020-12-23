import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_golb/features/auth/data/auth_datasource.dart';
import 'package:zoom_golb/features/splash/bloc/splash_bloc.dart';
import 'package:zoom_golb/features/splash/data/splash_datasource.dart';

class SplashProvider {
  SplashProvider._();

  static final splashBloc = Provider<SplashBloc>((ref) {
    SplashBloc _bloc = SplashBloc(datasource: SplashDatasourceImp());

    return _bloc;
  });
}
