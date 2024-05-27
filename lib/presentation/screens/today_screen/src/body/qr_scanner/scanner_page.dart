import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';
import 'dart:developer';
import 'package:queue/presentation/screens/today_screen/src/body/qr_scanner/scanner_states.dart';
import 'package:queue/data/encryprion.dart';
import 'package:queue/entities/export.dart';
import 'package:mobile_scanner/mobile_scanner.dart' deferred as mobile_scanner;
part 'scanner_page_cubit.dart';

const _name = 'QrScannerRoute';

@RoutePage(name: _name)
class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

final GlobalKey _widgetKey = GlobalKey();

class _ScannerPageState extends State<ScannerPage> {
  late final MobileScannerController controller;
  late final Widget scanner;
  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final databaseService = context.read<DatabaseService>();
    final cubit = ScannerPageCubit(databaseService);

    return BlocProvider.value(
        value: cubit,
        child: BlocBuilder<ScannerPageCubit, ScannerPageState>(builder: (context, state) {
          if (state is LoadedLibraryState) {
            controller = mobile_scanner.MobileScannerController(
              detectionSpeed: mobile_scanner.DetectionSpeed.normal,
            );
          }
          return SafeArea(
              child: LoadingContainer<ScannerPageCubit, ScannerPageState>(
                  cubit: cubit,
                  child: state is ShowResultState
                      ? const Center(child: Text("Result"))
                      : (state is LoadingLibraryState)
                          ? const CircularProgressIndicator()
                          : Scaffold(
                              floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
                              body: GestureDetector(
                                onTap: () => context.maybePop(),
                                child: Stack(
                                  children: [
                                    mobile_scanner.MobileScanner(
                                        key: _widgetKey,
                                        controller: controller,
                                        errorBuilder: (p0, p1, p2) => Center(
                                              child: Text(p1.errorDetails?.message ?? ''),
                                            ),
                                        onDetect: (barcodes) {
                                          log('Detected');
                                          controller.stop();
                                          cubit.onScan(barcodes.barcodes.first.rawValue ?? '');
                                        }),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                        child: Text(
                                          "Сканируйте QR код чтобы добавить друга без интернета в очередь",
                                          style:
                                              Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )));
        }));
  }
}
