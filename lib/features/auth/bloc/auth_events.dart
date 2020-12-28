import 'package:meta/meta.dart';

import 'package:zoom_golb/core/base_bloc/base_bloc.dart';

abstract class AuthEvent extends BaseEvent {}

class AuthEventToggleObscure extends AuthEvent {
  final bool obscurePassword;

  AuthEventToggleObscure(this.obscurePassword);
}

class AuthEventSubmit extends AuthEvent {
  final String email;
  final String password;
  final Function success;
  AuthEventSubmit({
    @required this.email,
    @required this.password,
    @required this.success,
  });
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  final Function success;
  AuthEventRegister({
    this.email,
    this.password,
    this.success,
  });
}

class AuthEventInit extends AuthEvent {
  final Function success;

  AuthEventInit(this.success);
}
