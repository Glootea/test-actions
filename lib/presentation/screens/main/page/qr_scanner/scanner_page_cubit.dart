import 'dart:developer';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/data/encryprion.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/presentation/screens/main/page/qr_scanner/scanner_states.dart';
import 'package:queue/presentation/screens/main/page/today_screen/today_screen_cubit.dart';

class ScannerPageCubit extends LoadableCubit<ScannerPageState> {
  final DatabaseService _databaseService;

  ScannerPageCubit(this._databaseService) : super(ScanningState());
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
