import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_golb/core/db/db.dart';
import 'package:zoom_golb/features/auth/bloc/auth_bloc.dart';
import 'package:zoom_golb/features/auth/data/auth_datasource.dart';
import 'package:zoom_golb/features/auth/data/firebase_api_auth.dart';

class AuthProvider {
  AuthProvider._();

  static final _fireBaseAuthProvider = Provider<FirebaseApiAuth>((ref) {
    return FirebaseApiAuth();
  });

  static final authBloc = Provider.autoDispose<AuthBloc>((ref) {
    AuthBloc _bloc = AuthBloc(
        AuthDataSource(ref.read<FirebaseApiAuth>(_fireBaseAuthProvider), ref.read(DbProvider.db)));
    ref.onDispose(() {
      _bloc.dispose();
    });
    return _bloc;
  });
}
