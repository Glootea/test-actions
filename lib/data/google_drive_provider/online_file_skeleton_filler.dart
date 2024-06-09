import 'package:gsheets/gsheets.dart';
import 'package:queue/data/online_database_strings.dart';

class OnlineFileSkeletonFiller {
  static Future<void> fillInfoFile(String fileID) async {
    final gsheets = GSheets(const String.fromEnvironment('CREDENTIALS'));
    final spreadsheet = await gsheets.spreadsheet(fileID);
    final insertNames = spreadsheet.addWorksheet(OnlineDatabaseStrings.namesSheetName);
    final insertLessons = spreadsheet.addWorksheet(OnlineDatabaseStrings.lessonsSheetName);
    final insertLessonTimes = spreadsheet.addWorksheet(OnlineDatabaseStrings.lessonTimesSheetName);
    final insertInfo = spreadsheet.addWorksheet(OnlineDatabaseStrings.infoFileName);
    final result = await Future.wait([insertInfo, insertNames, insertLessons, insertLessonTimes]);
    final _ = await spreadsheet.deleteWorksheet(spreadsheet.worksheetByIndex(0)!);
    final fillInfo1 = result[0].values.insertRow(1, [OnlineDatabaseStrings.keys, OnlineDatabaseStrings.values]);
    final fillInfo2 = result[0].values.insertColumn(
          1,
          [
            OnlineDatabaseStrings.group,
            OnlineDatabaseStrings.groupLeader,
            OnlineDatabaseStrings.admins,
          ],
          fromRow: 2,
        );
    final fillNames = result[1].values.insertRow(1, [OnlineDatabaseStrings.nameSurname]);
    final fillLessons = result[2].values.insertRow(1, [
      OnlineDatabaseStrings.id,
      OnlineDatabaseStrings.name,
      OnlineDatabaseStrings.tableID,
      OnlineDatabaseStrings.autodelete,
      OnlineDatabaseStrings.useDoneWorkCount,
    ]);
    final fillLessonTimes = result[3].values.insertRow(1, [
      OnlineDatabaseStrings.id,
      OnlineDatabaseStrings.dates,
      OnlineDatabaseStrings.weekdays,
      OnlineDatabaseStrings.startTime,
      OnlineDatabaseStrings.endTime,
    ]);
    await Future.wait([fillInfo1, fillInfo2, fillNames, fillLessons, fillLessonTimes]);
  }
}
