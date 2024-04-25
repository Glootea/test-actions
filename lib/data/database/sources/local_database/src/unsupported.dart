import 'package:drift/drift.dart';
import 'package:queue/data/database/sources/local_database/new_local_database.dart';

NewLocalDatabase constructDb() => throw UnimplementedError();
DatabaseConnection connect() {
  _unsupported();
}

Never _unsupported() {
  throw UnsupportedError('No suitable database implementation was found on this platform.');
}
