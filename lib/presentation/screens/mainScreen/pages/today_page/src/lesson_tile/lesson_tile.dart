import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/presentation/screens/mainScreen/pages/today_page/src/lesson_tile/src/qr_button.dart';
import 'package:queue/presentation/screens/mainScreen/pages/today_page/src/lesson_tile/src/create_rec_button.dart';
import 'package:queue/presentation/screens/mainScreen/pages/today_page/src/lesson_tile/src/start_reg_countdown.dart';
import 'package:intl/intl.dart';
import 'package:queue/presentation/screens/mainScreen/pages/today_page/src/lesson_tile/src/expand_button.dart';

class LessonTile extends StatefulWidget {
  //TODO: fix text color to black
  final LessonDisplayedEntity lesson;
  const LessonTile(this.lesson, {super.key});

  @override
  State<LessonTile> createState() => _LessonTileState();
}

class _LessonTileState extends State<LessonTile> {
  DateTime get now => DateTime.now();

  late bool displayedRegState;
  late Timer timer;

  bool expanded = false;

  @override
  void initState() {
    displayedRegState = widget.lesson.regIsActive;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (displayedRegState == false && widget.lesson.regIsActive) {
        setState(() {
          displayedRegState = true;
        });
      } else if (displayedRegState == true && !widget.lesson.regIsActive) {
        setState(() {
          displayedRegState = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        expanded = !expanded;
      }),
      child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 1200),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Gap(8),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          widget.lesson.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    ExpandButton(expanded),
                  ],
                ),
                const Gap(8),
                SizedBox(
                  height: 56,
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: (widget.lesson.userRec == null)
                                ? (!widget.lesson.showTimer)
                                    ? Text(
                                        displayedRegState ? "Запись открыта" : "Запись закрыта",
                                      )
                                    : StartRecCountDown(widget.lesson.startTime)
                                : Text(
                                    "Запись от ${DateFormat('yyyy-MM-dd в kk:mm:ss').format(widget.lesson.userRec!.time)}",
                                  )),
                      ),
                      // const Spacer(),
                      if (widget.lesson.userRec != null)
                        Icon(
                          Icons.save_outlined,
                          size: 20,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      const Gap(8),
                      if (widget.lesson.userRec != null)
                        (widget.lesson.userRec != null && (widget.lesson.userRec!.isUploaded))
                            ? Icon(
                                Icons.wifi_outlined,
                                size: 20,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              )
                            : Icon(
                                Icons.wifi_off_outlined,
                                size: 20,
                                color: Theme.of(context).colorScheme.error,
                              ),

                      const Gap(8),
                      if (displayedRegState || widget.lesson.userRec != null)
                        SizedBox(height: 40, child: CreateRecButton(widget.lesson)),
                    ],
                  ),
                ),
                if (widget.lesson.userRec != null) const Gap(8),
                if (widget.lesson.userRec != null)
                  Row(
                    children: [
                      Text(
                          widget.lesson.userQueuePosition == 0
                              ? "Очередь\nнедоступна"
                              : "Вы ${widget.lesson.userQueuePosition ?? '?'} в очереди",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headlineSmall),
                      const Spacer(),
                      if (widget.lesson.userRec?.isUploaded == false)
                        SizedBox(height: 32, child: showQrButton(widget.lesson.name, widget.lesson.userRec!.time)),
                      const Gap(8),
                      // const Gap(16)
                    ],
                  ),
                AnimatedCrossFade(
                    firstChild: const SizedBox(width: double.infinity),
                    secondChild: SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(8),
                          const Text(
                            "Очередь: ",
                            textAlign: TextAlign.left,
                          ),
                          const Gap(8),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.lesson.recs.length,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      const Gap(8),
                                      Text("${index + 1}"),
                                      const Spacer(),
                                      Text(widget.lesson.recs[index].userName),
                                      const Gap(8),
                                    ],
                                  ))
                        ],
                      ),
                    )),
                    sizeCurve: Curves.easeInOut,
                    crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 1200)),
                const Gap(8),
              ],
            ),
          )
          //   child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //     const Gap(8),
          //     Flexible(
          //       child: Column(
          //         children: [
          //           const Gap(8),
          //           SingleChildScrollView(
          //             scrollDirection: Axis.horizontal,
          //             child: Text(
          //               widget.lesson.displayName,
          //               style: Theme.of(context).textTheme.headlineSmall,
          //             ),
          //           ),
          //           const Gap(8),
          //           Text(
          //             displayedRegState ? "Запись открыта" : "Запись закрыта",
          //             textAlign: TextAlign.center,
          //           ),
          //           if (!displayedRegState)
          //             TimerStartReg(widget.lesson.pair.startTime),
          //           const Gap(8),
          //         ],
          //       ),
          //     ),
          //     const Gap(8),
          //     if (displayedRegState)
          //       SizedBox(
          //         width: 148,
          //         child: Column(
          //             children: <Widget>[RecButton(widget.lesson)] +
          //                 ((widget.lesson.userRec != null)
          //                     ? <Widget>[const QrButton()]
          //                     : [])),
          //       ),
          //     const Gap(8),
          //     AnimatedRotation(
          //       turns: expanded ? 0.5 : 0,
          //       duration: const Duration(milliseconds: 400),
          //       curve: Curves.easeInOut,
          //       child: const Icon(Icons.expand_more_outlined),
          //     ),
          //     const Gap(8),
          //   ]),
          // ),
          ),
    );
  }
}
