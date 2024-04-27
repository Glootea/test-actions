part of 'new_local_database.dart';

enum StoredValues { infoTableID, backgroundImage, userName, shouldUpdate, userIsAdmin, userRowNumber, isUpdatingQueue }

class KeyValueStorage {
  final LocalDatabase _database;

  KeyValueStorage(this._database);
  Future<String?> get(StoredValues storedValue) async => _database._get(storedValue);

  Future<void> set(StoredValues storedValue, String value) async => _database._set(storedValue, value);

  Future<void> clean(StoredValues storedValue) async => _database._clean(storedValue);
}
