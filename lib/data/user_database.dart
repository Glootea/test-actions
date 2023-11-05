import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserDataBase {
  final String _userName;
  String get getUserName => _userName;
  static const _userKey = "userName";
  static const _storage = FlutterSecureStorage();

  UserDataBase._(this._userName);

  static Future<UserDataBase?> configuredUserDataBase() async {
    final value = await _storage.read(key: _userKey);
    if (value != null) {
      return UserDataBase._(value);
    }
    return null;
  }

  static Future<void> fillUser(String userName) async {
    await _storage.write(key: _userKey, value: userName);
  }

  Future<void> logOut() async {
    await _storage.delete(key: _userKey);
  }
}
