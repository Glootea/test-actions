import 'package:queue/data/database/providers/local_database.dart';

class UserDataBase {
  final LocalDatabase _storage;
  String? _userName;
  String? get getUserName => _userName;
  bool? _isAdmin;
  bool get isAdmin => _isAdmin ?? false;

  UserDataBase._(this._storage);
  static Future<UserDataBase> getConfiguredUserDataBase(LocalDatabase storage) async {
    final db = UserDataBase._(storage);
    final userName = await storage.get(StoredValues.userName);
    if (userName != null) {
      db.fillUser(userName);
    }
    return db;
  }

  Future<void> fillUser(String userName) async {
    //TODO: fix broken auth from memory
    await _storage.set(StoredValues.userName, userName);
    _userName = userName;
    // _storage.isAdmin(userName).then((value) => _isAdmin = value);
    // await _storage.updateStudent(userName, newIsAdmin: true);
  }

  bool get userExist => _userName?.isNotEmpty ?? false;

  void logOut() {
    _storage.clean(StoredValues.userName);
  }
}
