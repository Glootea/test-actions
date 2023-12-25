import 'package:queue/data/database/local_database.dart';

class UserDataBase {
  final LocalDatabase _storage;
  String? _userName;
  String get getUserName => _userName!;
  bool? _isAdmin;
  bool get isAdmin => _isAdmin ?? false;

  UserDataBase._(this._storage);
  static Future<UserDataBase> getConfiguredUserDataBase(LocalDatabase storage) async {
    final db = UserDataBase._(storage);
    final userName = await storage.getUserName();
    if (userName != null) {
      db.fillUser(userName);
    }
    return db;
  }

  void fillUser(String userName) {
    _storage.setUserName(userName);
    _storage.isAdmin(userName).then((value) => _isAdmin = value);
  }

  bool get userExist => _userName?.isNotEmpty ?? false;

  void logOut() {
    _storage.deleteUserName();
  }
}
