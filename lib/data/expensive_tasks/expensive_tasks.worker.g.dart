// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expensive_tasks.dart';

// **************************************************************************
// Generator: WorkerGenerator 2.4.2
// **************************************************************************

/// WorkerService class for ExpensiveTasks
class _$ExpensiveTasksWorkerService extends ExpensiveTasks
    implements WorkerService {
  _$ExpensiveTasksWorkerService() : super();

  @override
  Map<int, CommandHandler> get operations => _operations;

  late final Map<int, CommandHandler> _operations =
      Map.unmodifiable(<int, CommandHandler>{
    _$createRecId: ($) => createRec($.args[0], $.args[1], $.args[2], $.args[3]),
    _$deleteRecId: ($) => deleteRec($.args[0], $.args[1], $.args[2], $.args[3]),
  });

  static const int _$createRecId = 1;
  static const int _$deleteRecId = 2;
}

/// Service initializer for ExpensiveTasks
WorkerService $ExpensiveTasksInitializer(WorkerRequest startRequest) =>
    _$ExpensiveTasksWorkerService();

/// Operations map for ExpensiveTasks
@Deprecated(
    'squadron_builder now supports "plain old Dart objects" as services. '
    'Services do not need to derive from WorkerService nor do they need to mix in '
    'with \$ExpensiveTasksOperations anymore.')
mixin $ExpensiveTasksOperations on WorkerService {
  @override
  // not needed anymore, generated for compatibility with previous versions of squadron_builder
  Map<int, CommandHandler> get operations => WorkerService.noOperations;
}

/// Worker for ExpensiveTasks
class ExpensiveTasksWorker extends Worker implements ExpensiveTasks {
  ExpensiveTasksWorker({PlatformWorkerHook? platformWorkerHook})
      : super($ExpensiveTasksActivator, platformWorkerHook: platformWorkerHook);

  @override
  Future<bool> createRec(String lessonTableID, String queueSheetName,
          int onlineTableRowNumber, String time) =>
      send(_$ExpensiveTasksWorkerService._$createRecId,
          args: [lessonTableID, queueSheetName, onlineTableRowNumber, time]);

  @override
  Future<bool> deleteRec(String lessonTableID, String queueSheetName,
          int onlineTableRowNumber, int? workCount) =>
      send(_$ExpensiveTasksWorkerService._$deleteRecId, args: [
        lessonTableID,
        queueSheetName,
        onlineTableRowNumber,
        workCount
      ]);
}

/// Worker pool for ExpensiveTasks
class ExpensiveTasksWorkerPool extends WorkerPool<ExpensiveTasksWorker>
    implements ExpensiveTasks {
  ExpensiveTasksWorkerPool(
      {ConcurrencySettings? concurrencySettings,
      PlatformWorkerHook? platformWorkerHook})
      : super(
            () => ExpensiveTasksWorker(platformWorkerHook: platformWorkerHook),
            concurrencySettings: concurrencySettings);

  @override
  Future<bool> createRec(String lessonTableID, String queueSheetName,
          int onlineTableRowNumber, String time) =>
      execute((w) => w.createRec(
          lessonTableID, queueSheetName, onlineTableRowNumber, time));

  @override
  Future<bool> deleteRec(String lessonTableID, String queueSheetName,
          int onlineTableRowNumber, int? workCount) =>
      execute((w) => w.deleteRec(
          lessonTableID, queueSheetName, onlineTableRowNumber, workCount));
}
