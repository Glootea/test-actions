import 'dart:developer';
import 'dart:math' as math;
import 'package:gsheets/gsheets.dart';
import 'package:queue/data/database/local_database.dart';
import 'package:queue/entities/lesson.dart';
import 'package:queue/entities/rec.dart';
import 'package:queue/secret/table_credentials.dart';

const String _queueSheetName = 'queue';
const String _workCountSheetName = 'workCount';
const String _lessonsSheetName = 'lessons';
const String _infoSheetName = 'info';

class OnlineDataBase {
  final _gsheets = GSheets(CREDENTIALS);
  Spreadsheet? _spreadsheet;
  Worksheet? _queueSheet;
  Worksheet? _workCount;
  Worksheet? _lessonsSheet;
  Worksheet? _infoSheet;
  List<String>? _nameColumn;
  List<String>? _subjectRow;
  final String _tableID;
  OnlineDataBase._(this._tableID);
  static OnlineDataBase? _instance;

  static Future<OnlineDataBase> instance(String tableID) async {
    if (_instance != null) {
      return _instance!;
    }
    _instance = OnlineDataBase._(tableID);
    final spreadsheet = await _instance!._gsheets.spreadsheet(tableID);

    final insertQueue = spreadsheet.addWorksheet(_queueSheetName);
    final insertWorkCount = spreadsheet.addWorksheet(_workCountSheetName);
    final insertLessons = spreadsheet.addWorksheet(_lessonsSheetName);
    final insertInfo = spreadsheet.addWorksheet(_infoSheetName);
    final result = await Future.wait([insertQueue, insertWorkCount, insertLessons, insertInfo]);
    final _ = await spreadsheet.deleteWorksheet(spreadsheet.worksheetByTitle("Лист1") ?? (await spreadsheet.addWorksheet("Лист1")));
    final fillQueue = result[0].values.insertValue("Студенты / Название предметов", column: 1, row: 1);
    final fillWorkCount = result[1].values.insertValue("Студенты / Название предметов", column: 1, row: 1);
    final fillLessons =
        result[2].values.insertRow(1, ["Название", "Даты", "День недели", "Время начала", "Время окончания", "Учитывать количество сданных работ"]);
    final fillInfo1 = result[3].values.insertRow(1, ["Ключи", "Значения"]);
    final fillInfo2 = result[3].values.insertColumn(1, ["Версия таблицы", "Группа", "Староста", "Админы"], fromRow: 2);
    await Future.wait([fillQueue, fillWorkCount, fillLessons, fillInfo1, fillInfo2]);
    return _instance!;
  }

  // final TABLEID = ''; //TODO: get ss id
  Future<List<RecEntity>> getData() async {
    final result = <RecEntity>[];
    try {
      _spreadsheet ??= await _gsheets.spreadsheet(_tableID);
      _queueSheet ??= _spreadsheet!.worksheetByTitle(_queueSheetName) ?? await _spreadsheet!.addWorksheet(_queueSheetName);
      final allColumns = await _queueSheet!.cells.allColumns();
      _nameColumn ??= (allColumns[0]).sublist(1).map((e) => e.value).where((element) => element.isNotEmpty).toList();
      _subjectRow ??= (allColumns.sublist(1).map((e) => e.first)).map((e) => e.value).where((element) => element.isNotEmpty).toList();
      // final columnCount = sheet.columnCount;
      for (int i = 0; i < _subjectRow!.length; i++) {
        result.addAll((allColumns[i + 1].sublist(1))
            .where((element) => element.value.isNotEmpty)
            .map((e) => RecEntity(_nameColumn![e.row - 2], DateTime.parse(e.value), _subjectRow![i]))
            .toList());
      }
    } catch (e) {
      log("Failed to load database");
      rethrow;
    }

    return result;
  }

  Future<bool> createRec(String lessonName, String userName, DateTime time) async {
    try {
      _spreadsheet ??= await _gsheets.spreadsheet(_tableID);
      _queueSheet ??= _spreadsheet!.worksheetByTitle(_queueSheetName) ?? await _spreadsheet!.addWorksheet(_queueSheetName);
      _nameColumn ??= (await _queueSheet!.cells.column(1)).map((e) => e.value).where((element) => element.isNotEmpty).toList();
      _subjectRow ??= (await _queueSheet!.cells.row(1)).map((e) => e.value).where((element) => element.isNotEmpty).toList();
      int row = _nameColumn!.indexOf(userName) + 2;
      int column = _subjectRow!.indexOf(lessonName) + 2;
      return await (await _queueSheet!.cells.cell(row: row, column: column)).post(time);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteRec(String lessonName, String userName) async {
    try {
      _spreadsheet ??= await _gsheets.spreadsheet(_tableID);
      _queueSheet ??= _spreadsheet!.worksheetByTitle(_queueSheetName) ?? await _spreadsheet!.addWorksheet(_queueSheetName);
      _nameColumn ??= (await _queueSheet!.cells.column(1)).map((e) => e.value).where((element) => element.isNotEmpty).toList();
      _subjectRow ??= (await _queueSheet!.cells.row(1)).map((e) => e.value).where((element) => element.isNotEmpty).toList();
      int row = _nameColumn!.indexOf(userName) + 2;
      int column = _subjectRow!.indexOf(lessonName) + 2;
      return await (await _queueSheet!.cells.cell(row: row, column: column)).post(null);
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
      _spreadsheet ??= await _gsheets.spreadsheet(_tableID);
      _queueSheet ??= _spreadsheet!.worksheetByTitle(_queueSheetName) ?? await _spreadsheet!.addWorksheet(_queueSheetName);
      _nameColumn ??= (await _queueSheet!.cells.column(1)).map((e) => e.value).where((element) => element.isNotEmpty).toList();
      _subjectRow ??= (await _queueSheet!.cells.row(1)).map((e) => e.value).where((element) => element.isNotEmpty).toList();
      int row = _nameColumn!.indexOf(userName) + 2;
      int column = _subjectRow!.indexOf(lessonName) + 2;
      final result = await (await _queueSheet!.cells.cell(row: row, column: column)).post(time);
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
    _spreadsheet ??= await _gsheets.spreadsheet(_tableID);
    _queueSheet ??= _spreadsheet!.worksheetByTitle(_queueSheetName) ?? await _spreadsheet!.addWorksheet(_queueSheetName);
    _nameColumn ??= (await _queueSheet!.cells.column(1)).map((e) => e.value).where((element) => element.isNotEmpty).toList();
    _subjectRow ??= (await _queueSheet!.cells.row(1)).map((e) => e.value).where((element) => element.isNotEmpty).toList();
    int row = _nameColumn!.indexOf(userName) + 2;
    int column = _subjectRow!.indexOf(lessonName) + 2;
    final r = (await _queueSheet!.cells.cell(row: row, column: column)).value;
    final result = r == time.toString();
    if (result) {
      final queue = (([...(await _queueSheet!.cells.column(column, fromRow: 2))].where((element) => element.value.isNotEmpty).toList()
        ..sort((a, b) => DateTime.parse(a.value).compareTo(DateTime.parse(b.value)))));
      final position = queue.indexWhere((element) => element.value == r) + 1;
      return {'name': userName, 'position': position.toString(), 'last': _nameColumn![queue[math.max(position - 2, 0)].row - 2]};
    } else {
      return null;
    }
  }

  Future<bool> fillStudents(List<StudentsCompanion> list) async {
    // TODO: sort by alphabet, but remember to fill head(now index = 0, won't be later)
    _spreadsheet = await _gsheets.spreadsheet(_tableID);
    _queueSheet ??= _spreadsheet!.worksheetByTitle(_queueSheetName) ?? await _spreadsheet!.addWorksheet(_queueSheetName);
    _workCount = _spreadsheet!.worksheetByTitle(_workCountSheetName) ?? await _spreadsheet!.addWorksheet(_workCountSheetName);
    _infoSheet ??= _spreadsheet!.worksheetByTitle(_infoSheetName) ?? await _spreadsheet!.addWorksheet(_infoSheetName);
    if (_queueSheet == null || _workCount == null) {
      throw Exception("Failed to load data for student insert");
    }
    List<Future> tasks = List.filled(4, Future.value(null), growable: false);
    tasks[0] = Future.value(_queueSheet?.cells.column(1));
    tasks[1] = Future.value(_workCount?.cells.column(1));
    final result = await Future.wait(tasks);
    final column1 = result[0].map((e) => e.value).toList();
    final column2 = result[1].map((e) => e.value).toList();
    List<int> adminId = [];
    if (column1 == null || column2 == null) {
      throw Exception("Failed to load data for student insert");
    }

    int i = 0;
    for (int j = 0; j < list.length; j++) {
      while (i + j < column1.length && column1[i + j].isNotEmpty) {
        i++;
      }
      if (list[j].isAdmin.value ?? false) {
        adminId.add(i + j);
      }
      if (i + j >= column1.length) {
        column1.add(list[j].name.value);
        column2.add(list[j].name.value);
      } else {
        column1[i + j] = list[j].name.value;
        column2[i + j] = list[j].name.value;
      }
    }
    tasks[0] = _queueSheet?.values.insertColumn(1, column1) ?? Future(() => null);
    tasks[1] = _workCount?.values.insertColumn(1, column2) ?? Future(() => null);
    tasks[2] = _infoSheet?.values.insertValueByKeys(adminId.join(', '), columnKey: "Значения", rowKey: "Админы") ?? Future(() => null);
    tasks[3] = _infoSheet?.values.insertValueByKeys(list[0].name.value, columnKey: "Значения", rowKey: "Староста") ?? Future(() => null);
    await Future.wait(tasks);
    return true;
  }

  Future<bool> fillLessons(List<LessonSettingEntity> list) async {
    // TODO: get new reference when starting new interaction with google sheet
    _spreadsheet ??= await _gsheets.spreadsheet(_tableID);
    _queueSheet = _spreadsheet!.worksheetByTitle(_queueSheetName) ?? await _spreadsheet!.addWorksheet(_queueSheetName);
    _workCount = _spreadsheet!.worksheetByTitle(_workCountSheetName) ?? await _spreadsheet!.addWorksheet(_workCountSheetName);
    int i = 0;
    while ((await _queueSheet?.cells.cell(row: 1, column: i + 2))?.value.isNotEmpty ?? true) {
      i++;
    }
    for (int j = 0; j < list.length; j++) {
      try {
        await (await _queueSheet?.cells.cell(row: 1, column: j + i + 2))?.post(list[j].name);
        await (await _workCount?.cells.cell(row: 1, column: j + i + 2))?.post(list[j].name);
      } catch (e) {
        log("Failed to insert lesson ${list[j].name}");
      }
    }
    return true;
  }
}
