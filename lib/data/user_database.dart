import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/data/database/sources/local_database/stored_values_enum.dart';

@Deprecated("Switched to cubit")
class UserDataBase {
  final LocalDatabase _storage;
  String? _userName;
  bool? _isAdmin;
  String get getUserName {
    if (_userName == null) {
      throw Exception("User name has not been set");
    }
    return _userName!;
  }

  bool get isAdmin => _isAdmin ?? false;

  UserDataBase._(this._storage);
  static Future<UserDataBase> getConfiguredUserDataBase(LocalDatabase storage) async {
    final db = UserDataBase._(storage);
    final userName = await storage.get(StoredValues.userName);
    if (userName != null) {
      db._userName = userName;
      db._isAdmin = await storage.isAdmin(userName);
    }
    return db;
  }

  Future<void> fillUser(String userName) async {
    await _storage.set(StoredValues.userName, userName);
    _userName = userName;
    _isAdmin = await _storage.isAdmin(userName);
  }

  bool get userExist => _userName?.isNotEmpty ?? false;

  void logOut() {
    _storage.clearAll();
    _userName = null;
    _isAdmin = null;
  }
}
