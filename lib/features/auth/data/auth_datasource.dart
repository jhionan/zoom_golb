import 'package:zoom_golb/features/auth/data/auth_api.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';

class AuthDataSource {
  final AuthApi _authApi;

  AuthDataSource(this._authApi);

  Stream<UserModel> loginWithEmailAndPassword(
      String email, String password) async* {
    yield* _authApi
        .loginWithEmail(email: email, password: password)
        .map((event) {
      if (event != null) {
        return UserModel(
            email: event.email,
            name: event.displayName,
            photoURL: event.photoURL);
      } else {
        throw 'Unknow Error';
      }
    });
  }

  Stream registerWithEmailAndPassword(String email, String password) async* {
    yield* _authApi
        .registerWithEmail(email: email, password: password)
        .map((event) {
      if (event != null) {
        return UserModel(
            email: event.email,
            name: event.displayName,
            photoURL: event.photoURL);
      } else {
        throw 'Unknow Error';
      }
    });
  }
}
