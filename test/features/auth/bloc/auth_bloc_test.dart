import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zoom_golb/features/auth/bloc/auth_bloc.dart';
import 'package:zoom_golb/features/auth/bloc/auth_events.dart';
import 'package:zoom_golb/features/auth/bloc/auth_states.dart';
import 'package:zoom_golb/features/auth/data/auth_api.dart';
import 'package:zoom_golb/features/auth/data/auth_datasource.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';

class AuthDatasourceMock extends Mock implements AuthDataSource {}

class AuthApiMock extends Mock implements AuthApi {}

class FirebaseFakeUser extends Fake implements User {
  @override
  String get displayName => 'User';
  @override
  String get email => 'teste@teste.com';

  @override
  String get photoURL => null;
}

class SucessMock extends Fake {
  void success() {}
}

main() {
  group('Bloc Tests', () {
    AuthDatasourceMock dataSourceMocked = AuthDatasourceMock();
    when(dataSourceMocked.loginWithEmailAndPassword(any, any)).thenAnswer(
        (value) => Stream.value(UserModel(
            email: 'teste@teste.com', name: 'teste', profilePicture: null)));

    when(dataSourceMocked.registerWithEmailAndPassword(
            'teste@teste.com', '123'))
        .thenAnswer((value) => Stream.value(UserModel(
            email: 'teste@teste.com', name: 'teste', profilePicture: null)));

    AuthBloc authBloc = AuthBloc(dataSourceMocked);

    test('login with email and password', () async {
      int successCalled = 0;
      void success() {
        successCalled++;
      }

      expectLater(
          authBloc.event$,
          emits(isA<AuthState>()
              .having((state) => state.loading, 'is loading = true', true)));

      expect(successCalled, 0);
      authBloc.inEvent.add(AuthEventSubmit(
          email: 'teste@teste.com', password: '123123', success: success));

      await untilCalled(dataSourceMocked.loginWithEmailAndPassword(any, any));

      verify(dataSourceMocked.loginWithEmailAndPassword(any, any)).called(1);

      await Future.microtask(() {}); // wait until the dart event loop complete
      expect(successCalled, 1);
    });

    test('toggle obscure', () async {
      bool obscure = true;
      expectLater(
          authBloc.event$,
          emitsInOrder([
            isA<AuthState>().having(
                (state) => state.obscurePassword, 'obscure = false', false),
            isA<AuthState>().having(
                (state) => state.obscurePassword, 'obscure = true', true),
          ]));
      authBloc.inEvent.add(AuthEventToggleObscure(!obscure));
      await Future.microtask(() {});
      authBloc.inEvent.add(AuthEventToggleObscure(obscure));
    });

    test('register with email and password', () async {
      int successCalled = 0;
      void success() {
        successCalled++;
      }

      expectLater(
          authBloc.event$,
          emits(isA<AuthState>()
              .having((state) => state.loading, 'is loading = true', true)));

      expect(successCalled, 0);
      authBloc.inEvent.add(AuthEventRegister(
          email: 'teste@teste.com', password: '123123', success: success));

      await untilCalled(
          dataSourceMocked.registerWithEmailAndPassword(any, any));

      verify(dataSourceMocked.registerWithEmailAndPassword(any, any)).called(1);

      await Future.microtask(() {}); // wait until the dart event loop complete
      expect(successCalled, 1);
    });
  });

  group('Datasource', () {
    AuthApiMock authApiMock = AuthApiMock();
    when(authApiMock.loginWithEmail(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((value) => Stream.value(FirebaseFakeUser()));
    when(authApiMock.registerWithEmail(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((value) => Stream.value(FirebaseFakeUser()));
    AuthDataSource datasource = AuthDataSource(authApiMock);

    test('login with email', () async {
      expectLater(
          datasource.loginWithEmailAndPassword('teste@teste.com', '123123'),
          emits(isA<UserModel>()
              .having((userModel) => userModel.name, 'name = User', 'User')));
      await untilCalled(authApiMock.loginWithEmail(
          email: anyNamed('email'), password: anyNamed('password')));
      verify(authApiMock.loginWithEmail(
              email: anyNamed('email'), password: anyNamed('password')))
          .called(1);
    });
    test('register with email', () async {
      expectLater(
          datasource.registerWithEmailAndPassword('teste@teste.com', '123123'),
          emits(isA<UserModel>()
              .having((userModel) => userModel.name, 'name = User', 'User')));
      await untilCalled(authApiMock.registerWithEmail(
          email: anyNamed('email'), password: anyNamed('password')));
      verify(authApiMock.registerWithEmail(
              email: anyNamed('email'), password: anyNamed('password')))
          .called(1);
    });
  });
}
