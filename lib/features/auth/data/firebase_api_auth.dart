import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:rxdart/rxdart.dart';

import 'package:zoom_golb/features/auth/data/auth_api.dart';

class FirebaseApiAuth implements AuthApi {
  fire.FirebaseAuth _firebaseAuth;
  FirebaseApiAuth() {
    _firebaseAuth = fire.FirebaseAuth.instance;
  }

  @override
  Stream forgotPassword(String email) async* {
    yield* _firebaseAuth.sendPasswordResetEmail(email: email).asStream();
  }

  @override
  Stream<fire.User> loginWithEmail({String email, String password}) async* {
    yield* Rx.combineLatest2<fire.UserCredential, fire.User, fire.User>(
        _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .asStream(),
        _firebaseAuth.authStateChanges(),
        (a, b) => b);
  }

  @override
  Stream loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Stream registerWithEmail({String email, String password}) async* {
    yield* Rx.combineLatest2<fire.UserCredential, fire.User, fire.User>(
        _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .asStream(),
        _firebaseAuth.authStateChanges(),
        (a, b) => b);
  }
}
