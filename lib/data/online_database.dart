import 'dart:developer';
import 'dart:math' as math;
import 'package:gsheets/gsheets.dart';
import 'package:queue/entities/rec.dart';
import 'package:queue/secret/table_credentials.dart';

class OnlineDataBase {
  static final _gsheets = GSheets(CREDENTIALS);
  static Spreadsheet? _spreadsheet;
  static Worksheet? _sheet;
  static List<String>? _nameColumn;
  static List<String>? _subjectRow;
  final TABLEURL = ''; //TODO: get ss id
  Future<List<RecEntity>> getData() async {
    final result = <RecEntity>[];
    try {
      _spreadsheet ??= await _gsheets.spreadsheet(TABLEURL);
      _sheet ??= _spreadsheet!.worksheetByTitle('queue');
      _sheet ??= await _spreadsheet!.addWorksheet('queue');
      final allColumns = await _sheet!.cells.allColumns();
      _nameColumn ??= (allColumns[0])
          .sublist(1)
          .map((e) => e.value)
          .where((element) => element.isNotEmpty)
          .toList();
      _subjectRow ??= (allColumns.sublist(1).map((e) => e.first))
          .map((e) => e.value)
          .where((element) => element.isNotEmpty)
          .toList();
      // final columnCount = sheet.columnCount;
      for (int i = 0; i < _subjectRow!.length; i++) {
        result.addAll((allColumns[i + 1].sublist(1))
            .where((element) => element.value.isNotEmpty)
            .map((e) => RecEntity(_nameColumn![e.row - 2],
                DateTime.parse(e.value), _subjectRow![i]))
            .toList());
      }
    } catch (e) {
      log("Failed to load database");
      rethrow;
    }

    return result;
  }

  Future<bool> createRec(
      String lessonName, String userName, DateTime time) async {
    try {
      _spreadsheet ??= await _gsheets.spreadsheet(TABLEURL);
      _sheet ??= _spreadsheet!.worksheetByTitle('queue');
      _sheet ??= await _spreadsheet!.addWorksheet('example');
      _nameColumn ??= (await _sheet!.cells.column(1))
          .map((e) => e.value)
          .where((element) => element.isNotEmpty)
          .toList();
      _subjectRow ??= (await _sheet!.cells.row(1))
          .map((e) => e.value)
          .where((element) => element.isNotEmpty)
          .toList();
      int row = _nameColumn!.indexOf(userName) + 2;
      int column = _subjectRow!.indexOf(lessonName) + 2;
      return await (await _sheet!.cells.cell(row: row, column: column))
          .post(time);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteRec(String lessonName, String userName) async {
    try {
      _spreadsheet ??= await _gsheets.spreadsheet(TABLEURL);
      _sheet ??= _spreadsheet!.worksheetByTitle('queue');
      _sheet ??= await _spreadsheet!.addWorksheet('example');
      _nameColumn ??= (await _sheet!.cells.column(1))
          .map((e) => e.value)
          .where((element) => element.isNotEmpty)
          .toList();
      _subjectRow ??= (await _sheet!.cells.row(1))
          .map((e) => e.value)
          .where((element) => element.isNotEmpty)
          .toList();
      int row = _nameColumn!.indexOf(userName) + 2;
      int column = _subjectRow!.indexOf(lessonName) + 2;
      return await (await _sheet!.cells.cell(row: row, column: column))
          .post(null);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> uploadFromQuery(String query) async {
    try {
      List<String> params = query.split("&&&").map((e) => e.trim()).toList();
      String lessonName = params[1];
      String userName = params[2];
      DateTime time = DateTime.parse(params[3]);
      _spreadsheet ??= await _gsheets.spreadsheet(TABLEURL);
      _sheet ??= _spreadsheet!.worksheetByTitle('queue');
      _sheet ??= await _spreadsheet!.addWorksheet('example');
      _nameColumn ??= (await _sheet!.cells.column(1))
          .map((e) => e.value)
          .where((element) => element.isNotEmpty)
          .toList();
      _subjectRow ??= (await _sheet!.cells.row(1))
          .map((e) => e.value)
          .where((element) => element.isNotEmpty)
          .toList();
      int row = _nameColumn!.indexOf(userName) + 2;
      int column = _subjectRow!.indexOf(lessonName) + 2;
      final result =
          await (await _sheet!.cells.cell(row: row, column: column)).post(time);
      return result;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<Map<String, String>?> recExist(String query) async {
    List<String> params = query.split("&&&").map((e) => e.trim()).toList();
    String lessonName = params[1];
    String userName = params[2];
    DateTime time = DateTime.parse(params[3]);
    _spreadsheet ??= await _gsheets.spreadsheet(TABLEURL);
    _sheet ??= _spreadsheet!.worksheetByTitle('queue');
    _sheet ??= await _spreadsheet!.addWorksheet('example');
    _nameColumn ??= (await _sheet!.cells.column(1))
        .map((e) => e.value)
        .where((element) => element.isNotEmpty)
        .toList();
    _subjectRow ??= (await _sheet!.cells.row(1))
        .map((e) => e.value)
        .where((element) => element.isNotEmpty)
        .toList();
    int row = _nameColumn!.indexOf(userName) + 2;
    int column = _subjectRow!.indexOf(lessonName) + 2;
    final r = (await _sheet!.cells.cell(row: row, column: column)).value;
    final result = r == time.toString();
    if (result) {
      final queue = (([...(await _sheet!.cells.column(column, fromRow: 2))]
          .where((element) => element.value.isNotEmpty)
          .toList()
        ..sort((a, b) =>
            DateTime.parse(a.value).compareTo(DateTime.parse(b.value)))));
      final position = queue.indexWhere((element) => element.value == r) + 1;
      return {
        'name': userName,
        'position': position.toString(),
        'last': _nameColumn![queue[math.max(position - 2, 0)].row - 2]
      };
    } else {
      return null;
    }
  }
}
