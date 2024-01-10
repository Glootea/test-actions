import 'package:queue/data/database/providers/local_database.dart';

class UserDataBase {
  final LocalDatabase _storage;
  String? _userName;
  bool? _isAdmin;
  String? get getUserName => _userName;
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
    //TODO: fix broken auth from memory
    await _storage.set(StoredValues.userName, userName);
    _userName = userName;
    _isAdmin = await _storage.isAdmin(userName);
  }

  bool get userExist => _userName?.isNotEmpty ?? false;

  void logOut() {
    _storage.clean(StoredValues.userName);
    _userName = null;
    _isAdmin = null;
  }
}
