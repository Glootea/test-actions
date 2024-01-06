import 'package:drift/drift.dart';
import 'package:queue/data/database/providers/local_database.dart';

LocalDatabase constructDb() => throw UnimplementedError();
DatabaseConnection connect() {
  _unsupported();
}

Never _unsupported() {
  throw UnsupportedError('No suitable database implementation was found on this platform.');
}
