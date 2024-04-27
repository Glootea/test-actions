import 'dart:developer';

import 'package:gsheets/gsheets.dart';
import 'package:queue/entities/src/lesson.dart';
import 'package:queue/entities/src/new_lesson_time.dart';
import 'package:queue/entities/src/new_queue_record.dart';
import 'package:queue/entities/src/subject.dart';
import 'package:queue/extension.dart';
import 'package:queue/secret/table_credentials.dart';

class OnlineDataBase {
  final GSheets _gsheets = GSheets(CREDENTIALS);

  /// {SpreadsheetID: Spreadsheet}
  final Map<String, Spreadsheet?> _spreadsheets = {};

  String? _infoTableIDBacked;
  set _infoTableID(String tableID) => _infoTableIDBacked = tableID;
  String get _getInfoTableID {
    if (_infoTableIDBacked == null) {
      throw Exception("OnlineDatabase is not configured: infoTableID is null");
    }
    return _infoTableIDBacked!;
  }

  /// Get cached spreadsheet or download and cache it
  Future<Spreadsheet> _getSpreadsheet(String tableID) async {
    final cached = _spreadsheets[tableID];
    if (cached != null) return cached;
    final spreadsheet = await _gsheets.spreadsheet(tableID);
    _spreadsheets[tableID] = spreadsheet;
    return spreadsheet;
  }

  /// Sets and configures (if necessary) infoTable spreadsheet
  Future<void> initialize(String infoTableID) async {
    _infoTableID = infoTableID;
    final infoSpreadsheet = await _getSpreadsheet(infoTableID);
    if (await _infoSpreadsheetConfigured(infoSpreadsheet) == false) {
      await _createInfoFileBase(infoSpreadsheet);
    }
    _spreadsheets[infoTableID] = infoSpreadsheet;
  }

  Future<bool> _infoSpreadsheetConfigured(Spreadsheet infoSpreadsheet) async => (infoSpreadsheet.sheets
      .map((e) => e.title)
      .toSet()
      .containsAll([_infoSheetName, _namesSheetName, _lessonsSheetName, _lessonTimesSheetName]));

  Future<void> _createInfoFileBase(Spreadsheet spreadsheet) async {
    Future<List<Worksheet>> addWorkSheets(Spreadsheet spreadsheet) async {
      final insertNames = spreadsheet.addWorksheet(_namesSheetName);
      final insertLessons = spreadsheet.addWorksheet(_lessonsSheetName);
      final insertLessonTimes = spreadsheet.addWorksheet(_lessonTimesSheetName);
      final insertInfo = spreadsheet.addWorksheet(_infoSheetName);
      final result = await Future.wait([insertInfo, insertNames, insertLessons, insertLessonTimes]);
      return result;
    }

    Future<void> fillWorkSheets(List<Worksheet> result) async {
      final fillInfo1 = result[0].values.insertRow(1, [_keys, _values]);
      final fillInfo2 = result[0].values.insertColumn(1, [_group, _groupLeader, _admins], fromRow: 2);
      final fillNames = result[1].values.insertRow(1, [_nameSurname]);
      final fillLessons = result[2].values.insertRow(1, [_id, _name, _tableID, _autodelete, _useDoneWorkCount]);
      final fillLessonTimes = result[3].values.insertRow(1, [_id, _dates, _weekdays, _startTime, _endTime]);
      await Future.wait([fillNames, fillLessonTimes, fillLessons, fillInfo1, fillInfo2]);
    }

    List<Worksheet> result = await addWorkSheets(spreadsheet);
    await _deleteDefaultWorkSheet(spreadsheet);
    await fillWorkSheets(result);
  }

  Future<void> _deleteDefaultWorkSheet(Spreadsheet spreadsheet) async =>
      spreadsheet.deleteWorksheet(spreadsheet.worksheetByIndex(0)!);

  Future<bool> _createFrameOfQueueTable(String fileID) async {
    final spreadsheet = await _getSpreadsheet(fileID);
    // final (queue, info) = await (
    //   spreadsheet.addWorksheet(_queueSheetName),
    //   spreadsheet.addWorksheet(_infoSheetName),
    // ).wait.whenComplete(() async => await _deleteDefaultWorkSheet(spreadsheet));
    final (queue, info, _) = await (
      spreadsheet.addWorksheet(_queueSheetName),
      spreadsheet.addWorksheet(_infoSheetName),
      _deleteDefaultWorkSheet(spreadsheet)
    ).wait;
    await (
      queue.values.insertRow(1, [_queueSheetName, _workCount]),
      info.values.insertRow(1, [_keys, _values]),
      info.values.insertColumn(1, [_infoTableIDString, _lastDelete], fromRow: 2),
      info.values.insertValue(_getInfoTableID, column: 2, row: 2)
    ).wait;
    return true;
  }

  Future<List<String?>> getStudentNameList() async {
    final spreadsheet = await _getSpreadsheet(_getInfoTableID);
    final names = spreadsheet.worksheetByTitle(_namesSheetName);
    final found = await names!.values.column(1, fromRow: 2);
    final result = found.getHandledBlanks;
    return result;
  }

  Future<List<DateTime?>> getRecTimeList(String tableID) async {
    final spreadsheet = await _getSpreadsheet(tableID);
    final lessonTimes = spreadsheet.worksheetByTitle(_lessonTimesSheetName);
    final found = await lessonTimes!.values.column(1, fromRow: 2);
    final result = found.getHandledBlanks;
    final times = result.map((cell) => cell == null ? null : DateTime.parse(cell)).toList();
    return times;
  }

  Future<List<int?>> getWorkCountList(String tableID) async {
    final spreadsheet = await _getSpreadsheet(tableID);
    final lessonTimes = spreadsheet.worksheetByTitle(_lessonTimesSheetName);
    final found = await lessonTimes!.values.column(1, fromRow: 2);
    final result = found.getHandledBlanks;
    final times = result.map((cell) => cell == null ? null : int.parse(cell)).toList();
    return times;
  }

  Future<SubjectInfo> getSubjectInfo(String tableID) async {
    final spreadsheet = await _getSpreadsheet(tableID);
    final info = spreadsheet.worksheetByTitle(_infoSheetName);
    final keys = await info!.values.column(1, fromRow: 2);
    final values = await info.values.column(2, fromRow: 2);
    final map = Map.fromIterables(keys.removeBlanks, values.getHandledBlanks);
    final result = SubjectInfo.fromMap(map);
    return result;
  }

  Future<List<Subject>> getSubjectList() async {
    final spreadsheet = await _getSpreadsheet(_getInfoTableID);
    final worksheet = spreadsheet.worksheetByTitle(_lessonsSheetName);
    final data = await worksheet!.values.allRows(fromRow: 2);
    final subjectList = data.map((row) => Subject.fromRow(row)).toList();
    return subjectList;
  }

  Future<List<NewLessonTime>> getLessonTimeList() async {
    final spreadsheet = await _getSpreadsheet(_getInfoTableID);
    final worksheet = spreadsheet.worksheetByTitle(_lessonTimesSheetName);
    final data = await worksheet!.values.allRows(fromRow: 2);
    final lessonTimeList = data.map((row) => _parseLessonTime(row)).toList();
    return lessonTimeList;
  }

  NewLessonTime _parseLessonTime(List<String> row) {
    return _isWeeklyLesson(row) ? NewWeeklyLessonEntity.fromRow(row) : NewDatedLessonEntity.fromRow(row);
  }

  bool _isWeeklyLesson(List<String> row) => row[1] == '-';

  Future<List<String>> getNameList() async {
    final spreadsheet = await _getSpreadsheet(_getInfoTableID);
    final worksheet = spreadsheet.worksheetByTitle(_namesSheetName);
    final data = await worksheet!.values.row(1, fromColumn: 2);
    return data;
  }

  Future<void> writeRec(
      {required String tableID, required int rowNumber, required DateTime time, int? workCount}) async {
    final row = [time.toRecTime, workCount?.toString() ?? ''].toOnline; // TODO: maybe rework to pass recOnline object
    final spreadsheet = await _getSpreadsheet(tableID);
    final queueWorksheet = spreadsheet.worksheetByTitle(_queueSheetName);
    await queueWorksheet!.values.insertRow(rowNumber, row);
  }

  Future<void> writeSubject(Subject subject, int rowNumber) async {
    final spreadsheet = await _getSpreadsheet(_getInfoTableID);
    final worksheet = spreadsheet.worksheetByTitle(_lessonsSheetName);
    final row = subject.toRow;
    await worksheet!.values.insertRow(rowNumber, row);
  }

  Future<void> writeLessonTime(NewLessonTime lessonTime, int rowNumber) async {
    final spreadsheet = await _getSpreadsheet(_getInfoTableID);
    final worksheet = spreadsheet.worksheetByTitle(_lessonTimesSheetName);
    final row = lessonTime.toRow;
    await worksheet!.values.insertRow(rowNumber, row);
  }

  Future<void> writeName(String name, int rowNumber) async {
    final spreadsheet = await _getSpreadsheet(_getInfoTableID);
    final worksheet = spreadsheet.worksheetByTitle(_namesSheetName);
    await worksheet!.values.insertValue(name, row: rowNumber, column: 1);
  }

  Future<bool> addNewQueueRecord(NewQueueRecord queueRecord) async {
    try {
      final spreadsheet = await _getSpreadsheet(queueRecord.onlineTableID);
      final queueWorksheet = spreadsheet.worksheetByTitle(_queueSheetName);
      queueWorksheet!.values.insertRow(queueRecord.studentRowNumber, queueRecord.toOnlineRow);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteQueueRecord(NewQueueRecord queueRecord) async {
    try {
      final spreadsheet = await _getSpreadsheet(queueRecord.onlineTableID);
      final queueWorksheet = spreadsheet.worksheetByTitle(_queueSheetName);
      final row = ['', queueRecord.workCount.toString()].toOnline;
      queueWorksheet!.values.insertRow(queueRecord.studentRowNumber, row);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

const String _infoSheetName = 'info';
const String _namesSheetName = 'names';
const String _lessonsSheetName = 'lessons'; // TODO: rename to subjects
const String _lessonTimesSheetName = 'lessonTimes';
const String _queueSheetName = 'Queue';
const String _keys = 'Keys';
const String _values = 'Values';
const String _group = 'Group';
const String _groupLeader = 'Group Leader';
const String _admins = 'Admins';
const String _id = 'id';
const String _nameSurname = 'Name/Surname';
const String _name = 'Name';
const String _tableID = 'tableID';
const String _infoTableIDString = 'infoTableID';
const String _useDoneWorkCount = "Use done work count";
const String _workCount = "Work Count";
const String _autodelete = "Auto delete";
const String _lastDelete = "Last delete";
const String _dates = "Dates";
const String _weekdays = "Weekdays";
const String _startTime = "Start time";
const String _endTime = "End time";
