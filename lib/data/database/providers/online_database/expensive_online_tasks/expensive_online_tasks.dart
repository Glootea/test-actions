import 'package:gsheets/gsheets.dart';
import 'package:queue/secret/table_credentials.dart';
import 'package:squadron/squadron.dart';
import 'expensive_online_tasks.activator.g.dart';
import 'package:squadron/squadron_annotations.dart';
part 'expensive_online_tasks.worker.g.dart';
// Workflow for changing file:
// 1) dart run build_runner build - to create squadron boilerplate code. Temporaly remove drift_dev from pubspec.yaml for build
// 2) dart compile js lib\data\database\providers\online_database\expensive_online_tasks\expensive_online_tasks.web.g.dart -O2 -o lib\data\database\providers\online_database\expensive_online_tasks\expensive_online_tasks.web.g.dart.js

@SquadronService(web: true)
class ExpensiveOnlineTasks {
  static final gsheets = GSheets(CREDENTIALS);
  @SquadronMethod()
  Future<bool> createRec(String lessonTableID, String queueSheetName, int onlineTableRowNumber, String time) async {
    try {
      final queueSheet =
          await gsheets.spreadsheet(lessonTableID).then((value) => value.worksheetByTitle(queueSheetName));
      if (queueSheet == null) {
        throw Exception("Failed to load database");
      }
      return await queueSheet.values.insertValue(time, column: 1, row: onlineTableRowNumber);
    } on Exception {
      return false;
    }
  }

  @SquadronMethod()
  Future<bool> deleteRec(
    String lessonTableID,
    String queueSheetName,
    int onlineTableRowNumber,
  ) async {
    try {
      final queueSheet =
          await gsheets.spreadsheet(lessonTableID).then((value) => value.worksheetByTitle(queueSheetName));
      if (queueSheet == null) {
        throw Exception("Failed to load database");
      }
      return await queueSheet.values
          .insertValue('', column: 1, row: onlineTableRowNumber)
          .timeout(const Duration(seconds: 5), onTimeout: () => false);
    } on Exception {
      return false;
    }
  }
}
