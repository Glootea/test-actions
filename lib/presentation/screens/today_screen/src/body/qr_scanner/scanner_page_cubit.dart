part of 'scanner_page.dart';

class ScannerPageCubit extends LoadableCubit<ScannerPageState> {
  final DatabaseService _databaseService;

  ScannerPageCubit(this._databaseService) : super(LoadingLibraryState()) {
    mobile_scanner.loadLibrary().then((lib) {
      emit(LoadedLibraryState());
    });
  }
  Future<void> onScan(String string) async {
    emit(ScannedState());
    final data = string.split('/').last;
    final decryptedData = Encryption.decrypt(data);
    log(decryptedData);
    final result = await _databaseService.addNewQueueRecord(QueueRecord.parseFromString(data));
    // emit(result ? LoadedState() : ErrorState());
    await Future.delayed(const Duration(seconds: 2), () => emit(LoadedState()));
  }

  @override
  void emit(ScannerPageState state) {
    log(state.toString());
    super.emit(state);
  }

  @override
  void endLoading() {
    log("endLoading");
    emit((state as LoadedState).createShowResultState());
  }
}
