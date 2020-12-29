import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/core/navigation/app_routes.dart';
import 'package:zoom_golb/features/splash/bloc/splash_events.dart';
import 'package:zoom_golb/features/splash/bloc/splash_provider.dart';

class Splash extends ConsumerWidget {
  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
        final double y = -0.002;
    BaseBloc<SplashEvent, SplashState> _bloc = watch(SplashProvider.splashBloc);
    _bloc.inEvent.add(SplashEvent(success: () {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }));

    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.black,
          child: Transform(
            transform: Matrix4(
               1,0,0,0,
                0,1,0,y,
                0,0,1,0,
                0,0,0,1,
            )..rotateZ(y)..rotateY(y)..rotateX(y),
            child: Container(

              padding: EdgeInsets.only(right: 60, left: 20),
              child: Text(
                'Numa Galáxia não muito distante, em um planeta quase inofencivo existe um desenvolvedor apaixonado por Flutter.\n Jhionan',
                style: TextStyle(
                  color: Color(0xFFFFE81F),
                  fontSize: 26,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
