import 'package:zoom_golb/core/base_bloc/base_bloc.dart';

class AuthState extends BaseState {
  final bool obscurePassword;
  final String errorPassword;
  final String errorEmail;
  final String errorMessage;
  final bool loading;
  AuthState(
      {this.errorPassword,
      this.errorEmail,
      this.errorMessage,
      this.obscurePassword = true,
      this.loading = false});

  AuthState copyWith({
    bool obscurePassword,
    String errorPassword,
    String errorEmail,
    String errorMessage,
    bool loading,
  }) {
    return AuthState(
        obscurePassword: obscurePassword ?? this.obscurePassword,
        errorPassword: errorPassword ?? this.errorPassword,
        errorEmail: errorEmail ?? this.errorEmail,
        errorMessage: errorMessage ?? this.errorMessage,
        loading: loading ?? this.loading);
  }
}

class AuthStateUserNotFound extends AuthState {
  AuthStateUserNotFound({
    String errorPassword,
    String errorEmail,
    String errorMessage,
    bool obscurePassword,
    bool loading,
  }) : super(
            errorEmail: errorEmail,
            errorMessage: errorMessage,
            errorPassword: errorPassword,
            obscurePassword: obscurePassword,
            loading: loading);
}

class AuthStateError extends AuthState {
  AuthStateError({
    this.emailError,
    this.passwordError,
    this.errorMessage,
  });
  final String emailError;
  final String passwordError;
  final String errorMessage;
  final bool loading = false;
}
