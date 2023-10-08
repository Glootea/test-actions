import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:queue/secret.dart';

class UserDataBase {
  final String _userName;
  String get getUserName => _userName;
  static const _userKey = "userID";
  static const _storage = FlutterSecureStorage();

  UserDataBase._(this._userName);

  static Future<UserDataBase?> configuredUserDataBase() async {
    final value = await _storage.read(key: _userKey);
    if (value != null) {
      String? userName = STUDENTS[value];
      if (userName != null) {
        return UserDataBase._(userName);
      }
    }
    return null;
  }

  static Future<void> fillUser(String userID) async {
    await _storage.write(key: _userKey, value: userID);
  }

  Future<void> logOut() async {
    await _storage.delete(key: _userKey);
  }
}
