import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  late final MobileScannerController controller;
  @override
  void initState() {
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
    );
    // controller.stop();
    // controller.start();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // final _snackBarState = SnackBarState();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MobileScanner(
            controller: controller,
            onDetect: (barcodes) {
              log('Detected');
              controller.stop();
              context.read<QueueBloc>().add(UploadFromLinkEvent(barcodes.barcodes.first.rawValue ?? ''));
            }));
  }
}
