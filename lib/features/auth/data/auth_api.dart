import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class AuthApi {
  Stream<User> loginWithEmail(
      {@required String email, @required String password});
  Stream registerWithEmail({@required String email, @required String password});
  Stream loginWithGoogle();
  Stream forgotPassword(String email);
}
