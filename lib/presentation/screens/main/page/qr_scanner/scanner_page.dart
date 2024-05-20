import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:queue/data/database/database_service.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';
import 'dart:developer';

import 'package:queue/presentation/screens/main/page/qr_scanner/scanner_page_cubit.dart';
import 'package:queue/presentation/screens/main/page/qr_scanner/scanner_states.dart';

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
  late final Timer timer;
  bool cameraWorking = true;
  @override
  void initState() {
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
    );
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (isVisible()) {
        if (cameraWorking == false) {
          controller.start();
          setState(() {
            cameraWorking = true;
          });
        }
      } else {
        controller.stop();
        setState(() {
          cameraWorking = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    print("Dispose");
    timer.cancel();
    controller.stop();
    controller.dispose();
    super.dispose();
  }

  bool isVisible() {
    // final RenderObject? box = _widgetKey.currentContext?.findRenderObject(); //     !
    // print();
    print(context.routeData.name);
    if (context.router.topRoute.name == _name) {
      // final double yPosition = (box as RenderBox).localToGlobal(Offset.zero).dy; // !
      print('Widget is visible in the viewport');
      return true;
    } else {
      print('Widget is not visible.');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final databaseService = context.read<DatabaseService>();
    final cubit = ScannerPageCubit(databaseService);
    return BlocProvider.value(
        value: cubit,
        child: BlocBuilder<ScannerPageCubit, ScannerPageState>(
            builder: (context, state) => SafeArea(
                  child: LoadingContainer<ScannerPageCubit, ScannerPageState>(
                      cubit: cubit,
                      child: state == ShowResultState()
                          ? const Center(child: Text("Result"))
                          : Scaffold(
                              body: Stack(
                                children: [
                                  MobileScanner(
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
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                )));
  }
}
