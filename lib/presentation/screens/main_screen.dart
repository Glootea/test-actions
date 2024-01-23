import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/screens/admin_view.dart';
import 'package:queue/presentation/widgets/blured_box.dart';
import 'package:queue/presentation/widgets/connectiom_status.dart';
import 'package:queue/presentation/widgets/lesson_widget.dart';
import 'package:queue/presentation/widgets/padding.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;
  late final PageController pageController;
  late bool isAdmin;
  Image? backgroundImage;
  @override
  void initState() {
    final bloc = context.read<QueueBloc>();
    final state = (bloc.state as MainState);
    isAdmin = state.isAdmin;
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<QueueBloc, QueueState>(
          builder: (context, state) {
            if (state is! MainState) {
              return const Center(child: CircularProgressIndicator());
            }
            // MainState mainState = state as MainState;
            if (state.backgroundImageDecoded != null) {
              backgroundImage = Image.memory(state.backgroundImageDecoded!, repeat: ImageRepeat.repeat);
            } else {
              if (backgroundImage == null && state.backgroundImageDecoded == null) {
                backgroundImage = Image.asset("assets/panda.png", repeat: ImageRepeat.repeat);
              }
            }
            return Stack(
              children: [
                Positioned.fill(child: backgroundImage!),
                MediaQuery.of(context).size.width < 600
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConnectionStatusWidget(),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ConnectionStatusWidget(),
                        ],
                      ),
                Material(
                  color: Colors.transparent,
                  elevation: 20,
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [TodayView(mainState: state), const QRScannerView(), const AdminView()],
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: NavigationBar(
            selectedIndex: currentPage,
            onDestinationSelected: (value) {
              if (pageController.hasClients) {
                pageController.animateToPage(value, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
              } else {
                build(context);
              }

              setState(() {
                currentPage = value;
              });
            },
            destinations: [
              const NavigationDestination(icon: Icon(Icons.today_outlined), label: "Today"),
              const NavigationDestination(icon: Icon(Icons.qr_code_outlined), label: "Qr scanner"),
              if (isAdmin) const NavigationDestination(icon: Icon(Icons.admin_panel_settings_outlined), label: "Admin settings")
            ]),
      ),
    );
  }
}

class TodayView extends StatelessWidget {
  const TodayView({
    super.key,
    required this.mainState,
  });

  final MainState mainState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).size.width > 600 ? const EdgeInsets.symmetric(horizontal: 64.0) : const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MyPadding(),
            const MyPadding(),
            BluredBox(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7)),
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("Пары с очередью сегодня", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge))),
            ),
            const MyPadding(),
            (mainState.todayLessons.isEmpty)
                ? Text(
                    "Пар с очередью нет",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: mainState.todayLessons.length,
                    itemBuilder: (context, index) => LessonWidget(mainState.todayLessons[index]),
                    separatorBuilder: (context, index) => const MyPadding(),
                  ),
            const MyPadding(),
            OutlinedButton(
              style: Theme.of(context).outlinedButtonTheme.style,
              onPressed: () => context.read<QueueBloc>().add(UserLogOutEvent()),
              child: Text(
                "Выйти из аккаунта",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            // OutlinedButton(
            //   // TODO: удалить
            //   style: Theme.of(context).outlinedButtonTheme.style,
            //   onPressed: () => context.goNamed(''),
            //   child: Text(
            //     "Перейти к выбору себя",
            //     style: Theme.of(context).textTheme.bodyMedium,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key});

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
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
