import 'package:drift/drift.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';

LocalDatabase constructDb() => throw UnimplementedError();
DatabaseConnection connect() {
  _unsupported();
}

Never _unsupported() {
  throw UnsupportedError('No suitable database implementation was found on this platform.');
}
