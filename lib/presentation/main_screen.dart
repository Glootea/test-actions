import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/logic/bloc.dart';
import 'package:queue/logic/events.dart';
import 'package:queue/logic/states.dart';
import 'package:queue/presentation/login_screen.dart';
import 'package:queue/presentation/widgets/connectiom_status.dart';
import 'package:queue/presentation/widgets/lesson_widget.dart';
import 'package:queue/presentation/widgets/padding.dart';
import 'package:queue/secret.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;
  late final PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<QueueBloc, QueueState>(
            builder: (context, state) {
              if (state is! MainState) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                });
              }
              try {
                MainState mainState = state as MainState;
                return Stack(
                  children: [
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
                    PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        TodayView(mainState: mainState),
                        const QRScannerView()
                      ],
                    ),
                  ],
                );
              } catch (e) {
                log("Wrong state at transition. Not critical");
                return const Scaffold();
              }
            },
          ),
        ),
        bottomNavigationBar: NavigationBar(
            selectedIndex: currentPage,
            onDestinationSelected: (value) {
              pageController.animateToPage(value,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);

              setState(() {
                currentPage = value;
              });
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.today_outlined), label: "Today"),
              NavigationDestination(
                  icon: Icon(Icons.qr_code_outlined), label: "Qr scanner")
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
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 64.0)
          : const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const MyPadding(),
          const MyPadding(),
          Text(
            "Пары с очередью сегодня: ",
            style: Theme.of(context).textTheme.headlineLarge,
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
                  itemBuilder: (context, index) =>
                      LessonWidget(mainState.todayLessons[index]),
                  separatorBuilder: (context, index) => const MyPadding(),
                ),
          const MyPadding(),
          OutlinedButton(
              onPressed: () => context.read<QueueBloc>().add(UserLogOutEvent()),
              child: const Text("Выйти из аккаунта"))
        ],
      ),
    );
  }
}

class QRScannerView extends StatelessWidget {
  const QRScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AiBarcodeScanner(
        // onScan: (String value) {
        //   debugPrint(value);
        // },
        onScan: (String value) {
          final encrypter =
              enc.Encrypter(Salsa20(enc.Key.fromBase64(ENCRIPTION_KEY)));
          final decrypted = encrypter.decrypt(
              Encrypted(Uint8List.fromList(
                  base64.encode(utf8.encode(value)).codeUnits)),
              iv: enc.IV.fromLength(8));
          log(decrypted);
        },
      ),
    );
  }
}
