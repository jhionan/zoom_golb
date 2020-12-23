import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_golb/core/base_bloc/base_bloc.dart';
import 'package:zoom_golb/features/auth/bloc/auth_events.dart';
import 'package:zoom_golb/features/auth/bloc/auth_states.dart';
import 'package:zoom_golb/features/auth/data/auth_datasource.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthDataSource _authDataSource;

  AuthBloc(this._authDataSource);
  @override
  onData(AuthEvent event) {
    switch (event.runtimeType) {
      case AuthEventToggleObscure:
        AuthEventToggleObscure typedEvent = event;
        eventController.add(
            lastState?.copyWith(obscurePassword: typedEvent.obscurePassword) ??
                AuthState(obscurePassword: typedEvent.obscurePassword));
        break;
      case AuthEventSubmit:
        _loading();
        _validateAndSubmit(event);
        break;
      case AuthEventRegister:
        _loading();
        _validateAndRegister(event);
    }
  }

  void _validateAndSubmit(AuthEventSubmit event) {
    _authDataSource
        .loginWithEmailAndPassword(event.email, event.password)
        .listen((loginEvent) {
      event.success();
    }, onError: _onError);
  }

  _onError(Object error, StackTrace stack) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          eventController.add(AuthStateUserNotFound(
              obscurePassword: lastState?.obscurePassword));
          break;
        case 'weak-password':
          break;
        case 'email-already-in-use':
          break;
      }
    }
    print(error.toString());
  }

  void _validateAndRegister(AuthEventRegister event) {
    _authDataSource
        .registerWithEmailAndPassword(event.email, event.password)
        .listen((registerEvent) {
      event.success();
    }, onError: _onError);
  }

  void _loading([bool isLoading = true]) {
    eventController.add(lastState?.copyWith(loading: isLoading) ??
        AuthState(obscurePassword: isLoading));
  }
}
