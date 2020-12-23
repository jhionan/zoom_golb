import 'package:zoom_golb/core/base_bloc/base_bloc.dart';

class SplashEvent extends BaseEvent {
  final Function success;
  SplashEvent({
    this.success,
  });
}

class SplashState extends BaseState {}
