import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseApp {
  FirebaseApp._();

  Stream<bool> init() async* {
    yield ((await Firebase.initializeApp()) != null);
  }

  static final provideFirebaseApp = StreamProvider<bool>((ref) async* {
    yield* FirebaseApp._().init();
  });
}
