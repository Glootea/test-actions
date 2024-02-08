// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expensive_online_tasks.dart';

// **************************************************************************
// Generator: WorkerGenerator 2.4.2
// **************************************************************************

/// WorkerService class for ExpensiveOnlineTasks
class _$ExpensiveOnlineTasksWorkerService extends ExpensiveOnlineTasks
    implements WorkerService {
  _$ExpensiveOnlineTasksWorkerService() : super();

  @override
  Map<int, CommandHandler> get operations => _operations;

  late final Map<int, CommandHandler> _operations =
      Map.unmodifiable(<int, CommandHandler>{
    _$createRecId: ($) => createRec($.args[0], $.args[1], $.args[2], $.args[3]),
    _$deleteRecId: ($) => deleteRec($.args[0], $.args[1], $.args[2]),
  });

  static const int _$createRecId = 1;
  static const int _$deleteRecId = 2;
}

/// Service initializer for ExpensiveOnlineTasks
WorkerService $ExpensiveOnlineTasksInitializer(WorkerRequest startRequest) =>
    _$ExpensiveOnlineTasksWorkerService();

/// Operations map for ExpensiveOnlineTasks
@Deprecated(
    'squadron_builder now supports "plain old Dart objects" as services. '
    'Services do not need to derive from WorkerService nor do they need to mix in '
    'with \$ExpensiveOnlineTasksOperations anymore.')
mixin $ExpensiveOnlineTasksOperations on WorkerService {
  @override
  // not needed anymore, generated for compatibility with previous versions of squadron_builder
  Map<int, CommandHandler> get operations => WorkerService.noOperations;
}

/// Worker for ExpensiveOnlineTasks
class ExpensiveOnlineTasksWorker extends Worker
    implements ExpensiveOnlineTasks {
  ExpensiveOnlineTasksWorker({PlatformWorkerHook? platformWorkerHook})
      : super($ExpensiveOnlineTasksActivator,
            platformWorkerHook: platformWorkerHook);

  @override
  Future<bool> createRec(String lessonTableID, String queueSheetName,
          int onlineTableRowNumber, String time) =>
      send(_$ExpensiveOnlineTasksWorkerService._$createRecId,
          args: [lessonTableID, queueSheetName, onlineTableRowNumber, time]);

  @override
  Future<bool> deleteRec(String lessonTableID, String queueSheetName,
          int onlineTableRowNumber) =>
      send(_$ExpensiveOnlineTasksWorkerService._$deleteRecId,
          args: [lessonTableID, queueSheetName, onlineTableRowNumber]);
}

/// Worker pool for ExpensiveOnlineTasks
class ExpensiveOnlineTasksWorkerPool
    extends WorkerPool<ExpensiveOnlineTasksWorker>
    implements ExpensiveOnlineTasks {
  ExpensiveOnlineTasksWorkerPool(
      {ConcurrencySettings? concurrencySettings,
      PlatformWorkerHook? platformWorkerHook})
      : super(
            () => ExpensiveOnlineTasksWorker(
                platformWorkerHook: platformWorkerHook),
            concurrencySettings: concurrencySettings);

  @override
  Future<bool> createRec(String lessonTableID, String queueSheetName,
          int onlineTableRowNumber, String time) =>
      execute((w) => w.createRec(
          lessonTableID, queueSheetName, onlineTableRowNumber, time));

  @override
  Future<bool> deleteRec(String lessonTableID, String queueSheetName,
          int onlineTableRowNumber) =>
      execute((w) =>
          w.deleteRec(lessonTableID, queueSheetName, onlineTableRowNumber));
}
