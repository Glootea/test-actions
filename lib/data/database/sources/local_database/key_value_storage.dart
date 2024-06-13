part of 'local_database.dart';

enum StoredValues {
  infoTableID,
  showBackgroundImage,
  userName,
  shouldUpdate,
  userIsAdmin,
  userRowNumber,
  isUpdatingQueue,
  colorTheme,
  brightness,
  groupName,
  headmasterName,
  useAttendance,
  adminIDs,
}

class KeyValueStorage {
  KeyValueStorage(this._database);
  final LocalDatabase _database;
  Future<String?> get(StoredValues storedValue) async => _database._get(storedValue);

  Future<void> set(StoredValues storedValue, String value) async => _database._set(storedValue, value);

  Future<void> clean(StoredValues storedValue) async => _database._clean(storedValue);
}
