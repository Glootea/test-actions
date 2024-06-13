part of 'scanner_page.dart';

class ScannerPageCubit extends LoadableCubit<ScannerPageState> {
  ScannerPageCubit(this._databaseService) : super(LoadingLibraryState()) {
    mobile_scanner.loadLibrary().then((lib) {
      emit(LoadedLibraryState());
    });
  }
  final DatabaseService _databaseService;
  Future<void> onScan(String string) async {
    emit(ScannedState());
    final data = string.split('/').last;
    final decryptedData = Encryption.decrypt(data);
    log(decryptedData);
    final _ = await _databaseService.addNewQueueRecord(QueueRecord.parseFromString(data));
    // emit(result ? LoadedState() : ErrorState());
    await Future.delayed(const Duration(seconds: 2), () => emit(LoadedState()));
  }

  @override
  void emit(ScannerPageState state) {
    log(state.toString());
    super.emit(state);
  }

  @override
  void onEndLoading() {
    log('endLoading');
    emit((state as LoadedState).createShowResultState());
  }
}
