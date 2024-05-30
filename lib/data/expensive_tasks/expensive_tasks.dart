import 'package:gsheets/gsheets.dart';
import 'package:queue/data/expensive_tasks/expensive_tasks.activator.g.dart';
import 'package:squadron/squadron.dart';
import 'package:squadron/squadron_annotations.dart';

part 'expensive_tasks.worker.g.dart';

// Workflow for changing file:
// 1) dart run build_runner build - to create squadron boilerplate code. Temporaly remove drift_dev from pubspec.yaml for build
// 2) Change the path in the web.g file to expensive_tasks.web.g.dart.js
// 3) dart compile js lib\data\expensive_tasks\expensive_tasks.web.g.dart -O2 -o web\expensive_tasks.web.g.dart.js

@SquadronService(web: true)
class ExpensiveTasks {
  static final gsheets = GSheets(const String.fromEnvironment('CREDENTIALS'));
  @SquadronMethod()
  Future<bool> createRec(String lessonTableID, String queueSheetName, int onlineTableRowNumber, String time) async {
    try {
      final queueSheet =
          await gsheets.spreadsheet(lessonTableID).then((value) => value.worksheetByTitle(queueSheetName));
      if (queueSheet == null) {
        throw Exception('Failed to load database');
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
    int? workCount,
  ) async {
    try {
      final spreadSheet = await gsheets.spreadsheet(lessonTableID);
      final queueSheet = spreadSheet.worksheetByTitle(queueSheetName);
      if (queueSheet == null) {
        throw Exception('Failed to load database');
      }
      final task = ((workCount != null)
          ? queueSheet.values
              .insertValue(workCount, column: 2, row: onlineTableRowNumber)
              .timeout(const Duration(seconds: 5), onTimeout: () => false)
          : Future.value(true));

      return Future.wait([
        queueSheet.values
            .insertValue('', column: 1, row: onlineTableRowNumber)
            .timeout(const Duration(seconds: 5), onTimeout: () => false),
        task,
      ]).then((value) => value.every((element) => element));
    } on Exception {
      return false;
    }
  }
}
