import 'package:flutter/widgets.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:queue/data/google_sheets_api_wrapper/google_sheets_api_wrapper.dart';
import 'package:queue/data/online_database_strings.dart';

class OnlineFileSkeletonFiller {
  // static Future<void> fillInfoFile(String fileID) async {
  //   final gsheets = GSheets(const String.fromEnvironment('CREDENTIALS'));
  //   final spreadsheet = await gsheets.spreadsheet(fileID);
  //   final insertNames = spreadsheet.addWorksheet(OnlineDatabaseStrings.namesSheetName);
  //   final insertLessons = spreadsheet.addWorksheet(OnlineDatabaseStrings.lessonsSheetName);
  //   final insertLessonTimes = spreadsheet.addWorksheet(OnlineDatabaseStrings.lessonTimesSheetName);
  //   final insertInfo = spreadsheet.addWorksheet(OnlineDatabaseStrings.infoFileName);
  //   final result = await Future.wait([insertInfo, insertNames, insertLessons, insertLessonTimes]);
  //   final _ = await spreadsheet.deleteWorksheet(spreadsheet.worksheetByIndex(0)!);
  //   final fillInfo1 = result[0].values.insertRow(1, [OnlineDatabaseStrings.keys, OnlineDatabaseStrings.values]);

  //   final fillInfo2 = result[0].values.insertColumn(
  //         1,
  //         [
  //           OnlineDatabaseStrings.group,
  //           OnlineDatabaseStrings.groupLeader,
  //           OnlineDatabaseStrings.admins,
  //         ],
  //         fromRow: 2,
  //       );
  //   final fillNames = result[1].values.insertRow(1, [OnlineDatabaseStrings.nameSurname]);
  //   final fillLessons = result[2].values.insertRow(1, [
  //     OnlineDatabaseStrings.id,
  //     OnlineDatabaseStrings.name,
  //     OnlineDatabaseStrings.tableID,
  //     OnlineDatabaseStrings.autodelete,
  //     OnlineDatabaseStrings.useDoneWorkCount,
  //   ]);
  //   final fillLessonTimes = result[3].values.insertRow(1, [
  //     OnlineDatabaseStrings.id,
  //     OnlineDatabaseStrings.dates,
  //     OnlineDatabaseStrings.weekdays,
  //     OnlineDatabaseStrings.startTime,
  //     OnlineDatabaseStrings.endTime,
  //   ]);
  //   await Future.wait([fillInfo1, fillInfo2, fillNames, fillLessons, fillLessonTimes]);
  // }

  static Future<void> fillInfoFile(String fileID) async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(const String.fromEnvironment('CREDENTIALS')),
      ['https://www.googleapis.com/auth/spreadsheets'],
    );
    final api = SheetsApi(client);
    final spreadsheet = await api.spreadsheets.get(fileID);
    final createSheetsRequest = BatchUpdateSpreadsheetRequest()
      ..requests = [
        Request(
          addSheet: AddSheetRequest(properties: SheetProperties(title: OnlineDatabaseStrings.infoFileName, sheetId: 1)),
        ),
        Request(
          addSheet:
              AddSheetRequest(properties: SheetProperties(title: OnlineDatabaseStrings.namesSheetName, sheetId: 2)),
        ),
        Request(
          addSheet:
              AddSheetRequest(properties: SheetProperties(title: OnlineDatabaseStrings.lessonsSheetName, sheetId: 3)),
        ),
        Request(
          addSheet: AddSheetRequest(
            properties: SheetProperties(title: OnlineDatabaseStrings.lessonTimesSheetName, sheetId: 4),
          ),
        ),
        Request(deleteSheet: DeleteSheetRequest(sheetId: spreadsheet.sheets?.first.properties?.sheetId)),
      ];
    await api.spreadsheets.batchUpdate(createSheetsRequest, fileID, $fields: '*');

    final sheet = GoogleSheetsApiWrapper(client).sheet(fileID, SheetsList.info);
    await sheet.writeColumn([OnlineDatabaseStrings.keys, OnlineDatabaseStrings.values], column: 0);
  }
}
