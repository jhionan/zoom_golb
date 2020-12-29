import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_golb/core/db/db.dart';
import 'package:zoom_golb/features/auth/data/auth_api.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';

class AuthDataSource {
  final AuthApi _authApi;
  final Db _db;

  AuthDataSource(this._authApi, this._db);

  Stream<UserModel> loginWithEmailAndPassword(
      String email, String password) async* {
    yield* _authApi
        .loginWithEmail(email: email, password: password)
        .map((event) {
      if (event != null) {
        UserModel userModel = _userModelFromFirebase(event);
        _saveUser(userModel);
        return userModel;
      } else {
        throw 'Unknow Error';
      }
    });
  }

  Stream<UserModel> registerWithEmailAndPassword(
      String email, String password) async* {
    print('called');
    yield* _authApi
        .registerWithEmail(email: email, password: password)
        .map((event) {
      if (event != null) {
        UserModel userModel = _userModelFromFirebase(event);
        _saveUser(userModel);
        return userModel;
      } else {
        throw 'Unknow Error';
      }
    });
  }

  Stream<bool> isLoggedIn() async* {
    yield* _authApi.currentUser().map((user) => user != null).map((isLogged) {
      if (!isLogged) {
        _deleteUser();
      }
      return isLogged;
    });
  }

  void _saveUser(UserModel user) {
    _db.addUser(user);
  }

  void _deleteUser() {
    _db.deleteAll();
  }

  String _getEmailUser(String email) {
    return email.split('@').first;
  }

  UserModel _userModelFromFirebase(User user) {
    return UserModel(
        email: user.email,
        name: user?.displayName ?? _getEmailUser(user.email),
        profilePicture: user.photoURL,
        id: user.uid);
  }
}
