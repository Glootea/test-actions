import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:queue/data/database/tables.dart';
part 'database.g.dart';

@DriftDatabase(tables: [Recs, UserRecs, Lessons])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase._(QueryExecutor e) : super(e);

  factory LocalDatabase() => LocalDatabase._(_connectOnWeb());
  @override
  int get schemaVersion => 1;
}

DatabaseConnection _connectOnWeb() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'my_app_db', // prefer to only use valid identifiers here
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );

    if (result.missingFeatures.isNotEmpty) {
      // Depending how central local persistence is to your app, you may want
      // to show a warning to the user if only unrealiable implemetentations
      // are available.
      print('Using ${result.chosenImplementation} due to missing browser '
          'features: ${result.missingFeatures}');
    }

    return result.resolvedExecutor;
  }));
}
