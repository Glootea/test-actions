import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:gsheets/gsheets.dart';
import 'package:queue/data/expensive_tasks/expensive_tasks.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/extension.dart';
import 'package:queue/secret/table_credentials.dart';
part 'table_strings.dart';

class OnlineDataBase {
  static final _gsheets = GSheets(CREDENTIALS);
  Spreadsheet? _spreadsheet;
  Worksheet? _infoSheet;
  Worksheet? _namesSheet;
  Worksheet? _lessonsSheet;
  Worksheet? _lessonTimesSheet;
  final String _infoTableID;
  static final ExpensiveTasksWorker _worker = ExpensiveTasksWorker();
  // Map<String, String> mapLessonNameToId;
  // OnlineDataBase._(this._infoTableID, this.mapLessonNameToId);
  OnlineDataBase._(this._infoTableID);
  static OnlineDataBase? _instance;

  static Future<OnlineDataBase> instance({String? tableID}) async {
    if (_instance != null && tableID == null) {
      return _instance!;
    }

    // await worker.start();
    _instance = OnlineDataBase._(tableID!);
    try {
      final spreadsheet = await _gsheets.spreadsheet(tableID);
      if (spreadsheet.sheets
          .map((e) => e.title)
          .toSet()
          .containsAll([_infoSheetName, _namesSheetName, _lessonsSheetName, _lessonTimesSheetName])) {
        return _instance!;
      }
      await _createInfoFileBase(spreadsheet);
    } on SocketException {
      log("Failed to configure online database due to network error");
      return _instance!;
    }
    return _instance!;
  }

  static Future<void> _createInfoFileBase(Spreadsheet spreadsheet) async {
    final insertNames = spreadsheet.addWorksheet(_namesSheetName);
    final insertLessons = spreadsheet.addWorksheet(_lessonsSheetName);
    final insertLessonTimes = spreadsheet.addWorksheet(_lessonTimesSheetName);
    final insertInfo = spreadsheet.addWorksheet(_infoSheetName);
    final result = await Future.wait([insertInfo, insertNames, insertLessons, insertLessonTimes]);
    final _ = await spreadsheet.deleteWorksheet(spreadsheet.worksheetByIndex(0)!);
    final fillInfo1 = result[0].values.insertRow(1, [_keys, _values]);
    final fillInfo2 = result[0].values.insertColumn(
        1,
        [
          _group,
          _headMan,
          _admins,
        ],
        fromRow: 2);
    final fillNames = result[1].values.insertRow(1, [_nameSurname]);
    final fillLessons = result[2].values.insertRow(1, [
      _id,
      _name,
      _tableID,
      _autodelete,
      _useDoneWorkCount,
    ]);
    final fillLessonTimes = result[3].values.insertRow(1, [_id, _dates, _weekdays, _startTime, _endTime]);
    await Future.wait([fillNames, fillLessonTimes, fillLessons, fillInfo1, fillInfo2]);
  }

  Future<bool> createFrameOfQueueTable(String fileID) async {
    final spreadsheet = await _gsheets.spreadsheet(fileID);
    final workSheets =
        await Future.wait([spreadsheet.addWorksheet(_queueSheetName), spreadsheet.addWorksheet(_infoSheetName)])
            .whenComplete(() async => await spreadsheet.deleteWorksheet(spreadsheet.worksheetByIndex(0)!));
    final [queue, info] = workSheets;
    Future.wait([
      queue.values.insertRow(1, [_queueSheetName, _workCount]),
      info.values.insertRow(1, [_keys, _values]),
      info.values.insertColumn(1, [_infoTableIDString, _lastDelete], fromRow: 2),
      info.values.insertValue(_infoTableID, column: 2, row: 2)
    ]);
    return true;
  }

  Future<List<RecEntity>> getRecs(Map<int, String> students, String lessonName, String tableID) async {
    List<RecEntity> result = <RecEntity>[];
    try {
      final queueSheet = await _gsheets.spreadsheet(tableID).then((value) => value.worksheetByTitle(_queueSheetName));
      if (queueSheet == null) return result;
      final (onlineTimes, workCountString) =
          await (queueSheet.values.column(1, fromRow: 2), queueSheet.values.column(2, fromRow: 2)).wait;
      final workCountList = List.generate(onlineTimes.length, (index) => 0);

      for (int i = 0; i < workCountString.length; i++) {
        if (workCountString[i].isNotEmpty) {
          workCountList[i] = int.parse(workCountString[i]);
        }
      }
      for (int i = 0; i < onlineTimes.length; i++) {
        final onlineTime = onlineTimes[i];
        if (onlineTime.isNotEmpty) {
          final time = onlineTime.toRecDateTime;
          result.add(RecEntity(students[i + 2]!, time, lessonName, isUploaded: true, workCount: workCountList[i]));
        }
      }
    } catch (e) {
      log("Failed to get recs: $e");
    }
    return result;
  }

  static Future<(int, String?)> getQueuePosition(String queueTableID, int rowNumber) async {
    final [queueSheet, infoQueueSheet] = await _gsheets
        .spreadsheet(queueTableID)
        .then((value) => [value.worksheetByTitle(_queueSheetName), value.worksheetByTitle(_infoSheetName)]);
    final [onlineTimes as List<DateTime>?, studentNames as List<String>?] = await Future.wait([
      queueSheet?.values.column(1, fromRow: 2).then((value) => value.map((e) => e.toRecDateTime).toList())
          as Future<List<DateTime>>,
      infoQueueSheet?.values.valueByKeys(rowKey: _infoTableIDString, columnKey: _values).then((infoTableID) async =>
          (await _gsheets.spreadsheet(infoTableID!))
              .worksheetByTitle(_namesSheetName)
              ?.values
              .column(1, fromRow: 2)) as Future<List<String>?>
    ]);
    if (onlineTimes == null || studentNames == null) throw Exception("Failed to load database");
    String? userName;
    final sortedRecs = List.generate(onlineTimes.length, (index) {
      if (index + 2 == rowNumber) userName = studentNames[index];
      return RecEntity(studentNames[index], onlineTimes[index], 'junkLessonName');
    })
      ..sort();
    if (userName == null) throw Exception("Failed to find user");
    int queuePosition = sortedRecs.indexWhere((element) => element.userName == userName);
    if (queuePosition != 0) {
      return (queuePosition + 1, sortedRecs[queuePosition - 1].userName);
    }
    return (queuePosition + 1, null);
  }

  static Future<bool> createRec(String lessonTableID, int onlineTableRowNumber, DateTime time) async {
    try {
      return _worker.createRec(lessonTableID, _queueSheetName, onlineTableRowNumber, time.toRecTime.toOnline);
    } on Exception {
      return false;
    }
  }

  static Future<bool> deleteRec(String lessonTableID, int onlineTableRowNumber, {int? workCount}) async {
    try {
      return _worker.deleteRec(lessonTableID, _queueSheetName, onlineTableRowNumber, workCount);
    } on Exception {
      return false;
    }
  }

  Future<bool> fillStudents(List<StudentEntity> list) async {
    // TODO: sort by alphabet, but remember to fill head(now index = 0, won't be later)
    _spreadsheet = await _gsheets.spreadsheet(_infoTableID);
    List<Future> tasks = [];
    _namesSheet = _spreadsheet!.worksheetByTitle(_namesSheetName);
    _infoSheet = _spreadsheet!.worksheetByTitle(_infoSheetName);
    if (_namesSheet == null || _infoSheet == null) {
      tasks.add(_namesSheet == null ? _spreadsheet!.addWorksheet(_namesSheetName) : Future.value(null));
      tasks.add(_infoSheet == null ? _spreadsheet!.addWorksheet(_infoSheetName) : Future.value(null));
      final result = await Future.wait(tasks);
      _namesSheet = result[0];
      _infoSheet = result[1];
      tasks = [];
    }
    final result = await _namesSheet?.cells.column(1);
    if (_namesSheet == null || result == null) {
      throw Exception("Failed to load data for student insert");
    }
    List<String>? column = result.map((e) => e.value).toList();
    List<int> adminId = [];
    int i = 0;
    for (int j = 0; j < list.length; j++) {
      while (i + j < column.length && column[i + j].isNotEmpty) {
        i++;
      }
      if (list[j].isAdmin) {
        adminId.add(i + j + 1);
      }
      if (i + j >= column.length) {
        column.add(list[j].name);
      } else {
        column[i + j] = list[j].name;
      }
    }
    tasks.add(_namesSheet?.values.insertColumn(1, column) ?? Future(() => null));
    tasks.add(_infoSheet?.values.insertValueByKeys(adminId.join(', ').toOnline, columnKey: _values, rowKey: _admins) ??
        Future(() => null));
    await Future.wait(tasks);
    return true;
  }

  Future<List<StudentEntity>> getStudents() async {
    _spreadsheet = await _gsheets.spreadsheet(_infoTableID);
    _namesSheet = _spreadsheet!.worksheetByTitle(_namesSheetName);
    _infoSheet = _spreadsheet!.worksheetByTitle(_infoSheetName);
    final names = (await _namesSheet!.cells.column(1, fromRow: 2))
        .map((e) => e.value)
        .where((element) => element.isNotEmpty)
        .toList();
    final admins = (await _infoSheet!.values.valueByKeys(rowKey: _admins, columnKey: _values))
        ?.split(',')
        .map((e) => int.parse(e));
    return names.map((e) {
      final rowNumber = names.indexOf(e) + 2;
      return StudentEntity(e, rowNumber, isAdmin: admins!.contains(rowNumber));
    }).toList();
  }

  Future<String> getHeadName() async {
    _spreadsheet = await _gsheets.spreadsheet(_infoTableID);
    _infoSheet = _spreadsheet!.worksheetByTitle(_infoSheetName);
    return (await _infoSheet!.cells.cellByKeys(rowKey: _headMan, columnKey: _values))!.value;
  }

  Future<int?> getWorkCount(String tableID, int rowNumber) async {
    _spreadsheet = await _gsheets.spreadsheet(tableID);
    final queueSheet = _spreadsheet!.worksheetByTitle(_queueSheetName);
    final value = (await queueSheet!.cells.cell(row: rowNumber, column: 2)).value;
    return int.tryParse(value);
  }

  ///Returns List of [LessonSettingEntity] and lesson online table id
  Future<(Future<List<LessonSettingEntity>>, Future<List<String>>)> getLessons() async {
    _spreadsheet = await _gsheets.spreadsheet(_infoTableID);
    _lessonsSheet = _spreadsheet!.worksheetByTitle(_lessonsSheetName);
    _lessonTimesSheet = _spreadsheet!.worksheetByTitle(_lessonTimesSheetName);
    List<String> lessonIDs = [];
    final lessonTimes = await _lessonTimesSheet!.values.allRows(fromRow: 2);
    final lessons = _lessonsSheet!.values
        .allRows(fromRow: 2)
        .then((value) => value.map((lessonRow) async {
              lessonIDs.add(lessonRow[2]);
              final times = lessonTimes.where((lessonID) => lessonID[0] == lessonRow[0]).toList().map((time) {
                if (time[1] == '-') {
                  return WeeklyLessonSettingEntity(
                      time[3].toTimeOfDay, time[4].toTimeOfDay, time[2].split(',').map((e) => int.parse(e)).toList());
                } else {
                  final dates = time[1].split(',').map((e) => e.toDate).toList();
                  return DatedLessonSettingEntity(time[3].toTimeOfDay, time[4].toTimeOfDay, dates);
                }
              });
              final lesson =
                  LessonSettingEntity(lessonRow[1], times.toList(), lessonRow[3] == 'true', lessonRow[4] == 'true');
              return lesson;
            }))
        .then((value) => Future.wait(value.toList()));
    return (lessons, Future.value(lessonIDs));
  }

  Future<bool> fillGroupInfo(String headManName, String groupName) async {
    _spreadsheet = await _gsheets.spreadsheet(_infoTableID);
    _infoSheet = _spreadsheet!.worksheetByTitle(_infoSheetName);
    await Future.wait([
      _infoSheet?.values.insertValueByKeys(headManName, columnKey: _values, rowKey: _headMan) ?? Future(() => null),
      _infoSheet?.values.insertValueByKeys(groupName, columnKey: _values, rowKey: _group) ?? Future(() => null)
    ]);
    return true;
  }

  Future<bool> fillLessons(List<LessonSettingEntity> list, List<String> ids) async {
    // TODO: get new reference when starting new interaction with google sheet
    _spreadsheet = await _gsheets.spreadsheet(_infoTableID);
    _lessonsSheet = _spreadsheet!.worksheetByTitle(_lessonsSheetName);
    _lessonTimesSheet = _spreadsheet!.worksheetByTitle(_lessonTimesSheetName);
    List<Future> tasks = [];
    if (_lessonsSheet == null || _lessonTimesSheet == null) {
      tasks.add(_lessonsSheet == null ? _spreadsheet!.addWorksheet(_lessonsSheetName) : Future.value(null));
      tasks.add(_lessonTimesSheet == null ? _spreadsheet!.addWorksheet(_lessonTimesSheetName) : Future.value(null));
      final result = await Future.wait(tasks);
      _lessonsSheet = result[0];
      _lessonTimesSheet = result[1];
      tasks = [];
    }
    final lessonTable = await _lessonsSheet?.cells.allColumns();
    final lessonTimesTable = await _lessonTimesSheet?.cells.allColumns();
    int lessonIndex = 1;
    int lessonTimesIndex = 1;
    for (int i = 0; i < list.length; i++) {
      final lesson = list[i];
      if ((lessonIndex >= (lessonTable?[0].length ?? 0))) {
        lessonIndex++;
      } else {
        while (
            (lessonIndex < (lessonTable?[0].length ?? 0)) && (lessonTable?[0][lessonIndex].value.isNotEmpty ?? false)) {
          lessonIndex++;
        }
      }
      tasks.add(_lessonsSheet?.values.insertRow(lessonIndex, [
            lessonIndex,
            lesson.name,
            ids[i],
            lesson.autoDelete.toString().toOnline,
            lesson.useWorkCount.toString().toOnline,
          ]) ??
          Future.value(null));
      lessonTimesIndex = _taskToFillWeeklyLessons(lesson, lessonIndex, lessonTimesTable, lessonTimesIndex, tasks);
      lessonTimesIndex = _taskToFillDatedLessons(lesson, lessonIndex, lessonTimesTable, lessonTimesIndex, tasks);
    }
// TODO: check if tasks fill correctly
    await Future.wait(tasks);
    return true;
  }

  int _taskToFillDatedLessons(LessonSettingEntity lesson, int lessonIndex, List<List<Cell>>? lessonTimesTable,
      int lessonTimesIndex, List<Future<dynamic>> tasks) {
    final datedLessons = lesson.lessonTimes.whereType<DatedLessonSettingEntity>().toList();
    final datedLessonsLength = datedLessons.length;
    for (int j = 0; j < datedLessonsLength; j++) {
      if ((lessonTimesIndex >= (lessonTimesTable?[0].length ?? 0))) {
        lessonTimesIndex++;
      } else {
        while ((lessonTimesIndex < (lessonTimesTable?[0].length ?? 0)) &&
            (lessonTimesTable?[0][lessonTimesIndex].value.isNotEmpty ?? false)) {
          lessonTimesIndex++;
        }
      }
      final datedLesson = datedLessons[j];
      tasks.add(_taskToInsertSingleDatedLessonTime(
          lessonTimesIndex: lessonTimesIndex, lessonIndex: lessonIndex, datedLesson: datedLesson));
    }
    return lessonTimesIndex;
  }

  int _taskToFillWeeklyLessons(LessonSettingEntity lesson, int lessonIndex, List<List<Cell>>? lessonTimesTable,
      int lessonTimesIndex, List<Future<dynamic>> tasks) {
    final weeklyLessons = lesson.lessonTimes.whereType<WeeklyLessonSettingEntity>().toList();
    final weeklyLessonsLength = weeklyLessons.length;
    for (int j = 0; j < weeklyLessonsLength; j++) {
      if ((lessonTimesIndex >= (lessonTimesTable?[0].length ?? 0))) {
        lessonTimesIndex++;
      } else {
        while ((lessonTimesIndex < (lessonTimesTable?[0].length ?? 0)) &&
            (lessonTimesTable?[0][lessonTimesIndex].value.isNotEmpty ?? false)) {
          lessonTimesIndex++;
        }
      }
      final weeklyLesson = weeklyLessons[j];
      tasks.add(_taskToInsertSingleWeeklyLessonTime(
          lessonTimesIndex: lessonTimesIndex, lessonIndex: lessonIndex, weeklyLesson: weeklyLesson));
    }
    return lessonTimesIndex;
  }

  Future<void> _taskToInsertSingleWeeklyLessonTime(
      {required int lessonTimesIndex,
      required int lessonIndex,
      required WeeklyLessonSettingEntity weeklyLesson}) async {
    return _lessonTimesSheet?.values.insertRow(lessonTimesIndex, [
          lessonIndex,
          '-',
          weeklyLesson.weekdays.join(', ').toOnline,
          weeklyLesson.startTime.toShortString.toOnline,
          weeklyLesson.endTime.toShortString.toOnline
        ]) ??
        Future.value(null);
  }

  Future<void> _taskToInsertSingleDatedLessonTime(
      {required int lessonTimesIndex, required int lessonIndex, required DatedLessonSettingEntity datedLesson}) {
    return _lessonTimesSheet?.values.insertRow(lessonTimesIndex, [
          lessonIndex,
          datedLesson.date.map((e) => e.toOnlineDateString).join(',').toOnline,
          '-',
          datedLesson.startTime.toShortString.toOnline,
          datedLesson.endTime.toShortString.toOnline
        ]) ??
        Future.value(null);
  }

  // Future<DateTime?> getLastQueueDeleteTime(String tableID) async {
  //   final str = await _gsheets
  //       .spreadsheet(tableID)
  //       .then((value) => value.worksheetByTitle(_infoSheetName))
  //       .then((value) async => await value?.values.valueByKeys(rowKey: _values, columnKey: _lastDelete));
  //   if (str == null) throw Exception("Failed to load database");
  //   if (str.isNotEmpty) {
  //     return str.toRecDateTime;
  //   }
  //   return null;
  // }

  Future<bool> checkIfDeleteQueue(String tableID, DateTime lastLessonTime) async {
    final spreadSheet = await _gsheets.spreadsheet(tableID);
    final infoSheet = spreadSheet.worksheetByTitle(_infoSheetName);
    if (infoSheet == null) throw Exception("Failed to load database");
    final timeStr = await infoSheet.values.valueByKeys(columnKey: _values, rowKey: _lastDelete);
    if (timeStr?.isEmpty ?? false) return true;
    final lastDeleteTime = timeStr?.toDate;
    return lastDeleteTime?.isBefore(lastLessonTime) ?? true;
  }

  Future<bool> deleteQueue(String tableID) async {
    final time = DateTime.now();
    final spreadSheet = await _gsheets.spreadsheet(tableID);
    final queueSheet = spreadSheet.worksheetByTitle(_queueSheetName);
    final infoSheet = spreadSheet.worksheetByTitle(_infoSheetName);
    if (queueSheet == null || infoSheet == null) throw Exception("Failed to load database");
    final queueColumn = await queueSheet.values
        .column(1)
        .then((value) => value.map((e) => e == _queueSheetName ? _queueSheetName : '').toList());

    return Future.wait([
      queueSheet.values.insertColumn(1, queueColumn),
      infoSheet.values.insertValueByKeys(time.toOnlineDateString.toOnline, columnKey: _values, rowKey: _lastDelete)
    ]).then((value) => value.every((element) => element == true));
  }
}
