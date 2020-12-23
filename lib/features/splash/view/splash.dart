import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/core/navigation/app_routes.dart';
import 'package:zoom_golb/features/splash/bloc/splash_bloc.dart';
import 'package:zoom_golb/features/splash/bloc/splash_events.dart';
import 'package:zoom_golb/features/splash/bloc/splash_provider.dart';

class Splash extends ConsumerWidget {
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    BaseBloc<SplashEvent, SplashState> _bloc = watch(SplashProvider.splashBloc);
    _bloc.inEvent.add(SplashEvent(success: () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }));

    return Container(
      color: Colors.red,
    );
  }
}
