import 'dart:convert';

import 'package:flutter_riverpod/all.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zoom_golb/features/auth/data/user_model.dart';

abstract class Db {
  Future addUser(UserModel user);
  Future deleteAll();
  Future<UserModel> getUser();
}

class DbImp implements Db {
  final _storage = new FlutterSecureStorage();
  final _userKey = 'userModel';

  @override
  Future<void> addUser(UserModel user) async {
    return await _storage.write(
        key: _userKey, value: jsonEncode(user.toJson()));
  }

  @override
  Future<void> deleteAll() async {
    return await _storage.deleteAll();
  }

  @override
  Future<UserModel> getUser() async {
    return UserModel.fromJson(jsonDecode(await _storage.read(key: _userKey)));
  }
}

class DbProvider {
  DbProvider._();
  static final db = Provider<Db>((ref) {
    return DbImp();
  });
}
