import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

DatabaseConnection connect() {
  return DatabaseConnection.delayed(Future(() async {
    return NativeDatabase.createBackgroundConnection(
      await databaseFile,
    );
  }));
}

Future<File> get databaseFile async {
  await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = p.join(appDir.path, 'queue.db');
  return File(dbPath);
}
