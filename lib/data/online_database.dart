import 'dart:developer';

import 'package:gsheets/gsheets.dart';
import 'package:queue/models/rec.dart';
import 'package:queue/secret.dart';
import 'package:queue/secret/table_credentials.dart';

class OnlineDataBase {
  final _gsheets = GSheets(CREDENTIALS);
  List<String>? _nameColumn;
  List<String>? _subjectRow;
  Future<Map<String, List<Rec>>> getData(String userName) async {
    final result = <String, List<Rec>>{};
    final ss = await _gsheets.spreadsheet(TABLEURL);
    var sheet = ss.worksheetByTitle('queue');
    sheet ??= await ss.addWorksheet('example');
    _nameColumn ??= (await sheet.cells.column(1))
        .map((e) => e.value)
        .where((element) => element.isNotEmpty)
        .toList();
    _subjectRow ??= (await sheet.cells.row(1))
        .map((e) => e.value)
        .where((element) => element.isNotEmpty)
        .toList();
    // final columnCount = sheet.columnCount;
    for (int i = 0; i < _subjectRow!.length; i++) {
      result.addAll({
        (_subjectRow![i]): (await sheet.cells.column(i + 2, fromRow: 2))
            .where((element) => element.value.isNotEmpty)
            .map((e) => Rec(_nameColumn![e.row - 2], DateTime.parse(e.value)))
            .toList()
      });
    }

    return result;
  }

  Future<bool> createRec(
      String lessonName, String userName, DateTime time) async {
    try {
      final ss = await _gsheets.spreadsheet(TABLEURL);
      var sheet = ss.worksheetByTitle('queue');
      sheet ??= await ss.addWorksheet('example');
      _nameColumn ??=
          (await sheet.cells.column(1)).map((e) => e.value).toList();
      _subjectRow ??= (await sheet.cells.row(1)).map((e) => e.value).toList();
      int row = _nameColumn!.indexOf(userName) + 1;
      int column = _subjectRow!.indexOf(lessonName) + 1;
      return await (await sheet.cells.cell(row: row + 1, column: column + 1))
          .post(time);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteRec(String lessonName, String userName) async {
    try {
      final ss = await _gsheets.spreadsheet(TABLEURL);
      var sheet = ss.worksheetByTitle('queue');
      sheet ??= await ss.addWorksheet('example');
      _nameColumn ??=
          (await sheet.cells.column(1)).map((e) => e.value).toList();
      _subjectRow ??= (await sheet.cells.row(1)).map((e) => e.value).toList();
      int row = _nameColumn!.indexOf(userName) + 1;
      int column = _subjectRow!.indexOf(lessonName) + 1;
      return await (await sheet.cells.cell(row: row + 1, column: column + 1))
          .post(null);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
