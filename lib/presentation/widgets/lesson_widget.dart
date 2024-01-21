import 'dart:async';
import 'package:flutter/material.dart';
import 'package:queue/entities/export.dart';
import 'package:queue/extension.dart';
import 'package:queue/presentation/widgets/blured_box.dart';
import 'package:queue/presentation/widgets/padding.dart';
import 'package:queue/presentation/widgets/qr_button.dart';
import 'package:queue/presentation/widgets/rec_button.dart';
import 'package:queue/presentation/widgets/timer_start_reg.dart';
import 'package:intl/intl.dart';

class LessonWidget extends StatefulWidget {
  //TODO: fix text color to black
  final LessonEntity lesson;
  const LessonWidget(this.lesson, {super.key});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  DateTime get now => DateTime.now();
  TimeOfDay timerStartDelay = const TimeOfDay(minute: 11, hour: 0);

  late bool displayedRegState;

  bool get regIsActive => (timeToStart < timerStartDelay && const TimeOfDay(hour: 0, minute: 0) < timetillEnd);
  bool get showTimer => timeToStart < const TimeOfDay(hour: 0, minute: 30) && timerStartDelay < timeToStart;
  TimeOfDay get timeToStart => widget.lesson.startTime - TimeOfDay.fromDateTime(now);
  TimeOfDay get timetillEnd => widget.lesson.endTime - TimeOfDay.fromDateTime(now);

  late Timer timer;

  bool expanded = false;

  @override
  void initState() {
    displayedRegState = regIsActive;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (displayedRegState == false && regIsActive) {
        setState(() {
          displayedRegState = true;
        });
      } else if (displayedRegState == true && !regIsActive) {
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
      child: BluredBox(
        child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 1200),
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7)),
            child: Stack(children: [
              Column(
                children: [
                  const MySmallPadding(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MySmallPadding(),
                      Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            widget.lesson.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                          child: Icon(
                            Icons.expand_more_outlined,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const MySmallPadding(),
                  SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        const MySmallPadding(),
                        SizedBox(
                          height: 56,
                          child: Center(
                              child: (widget.lesson.userRec == null)
                                  ? (!showTimer)
                                      ? Text(
                                          displayedRegState ? "Запись открыта" : "Запись закрыта",
                                          textAlign: TextAlign.left,
                                        )
                                      : TimerStartReg(widget.lesson.startTime)
                                  : Text(
                                      "Запись от\n${DateFormat('yyyy-MM-dd в kk:mm:ss').format(widget.lesson.userRec!.time)}",
                                    )),
                        ),
                        const Spacer(),
                        if (displayedRegState || widget.lesson.userRec != null) SizedBox(height: 40, child: RecButton(widget.lesson)),
                        const MySmallPadding(),
                      ],
                    ),
                  ),
                  const MySmallPadding(),
                  if (widget.lesson.userRec != null)
                    Row(
                      children: [
                        const MySmallPadding(),
                        Text(widget.lesson.userQueuePosition == 0 ? "Очередь\nнедоступна" : "Вы ${widget.lesson.userQueuePosition ?? '?'} в очереди",
                            textAlign: TextAlign.start, style: Theme.of(context).textTheme.headlineSmall),
                        const Spacer(),
                        Icon(
                          Icons.save_outlined,
                          size: 20,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        const MySmallPadding(),
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
                        const MySmallPadding(),
                        SizedBox(height: 40, child: QrButton(widget.lesson.name)),
                        const MySmallPadding(),
                      ],
                    ),
                  const MySmallPadding(),
                  AnimatedCrossFade(
                      firstChild: const SizedBox(width: double.infinity),
                      secondChild: SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Очередь: ",
                              textAlign: TextAlign.left,
                            ),
                            const MySmallPadding(),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.lesson.recs.length,
                                itemBuilder: (context, index) => Row(
                                      children: [
                                        const MySmallPadding(),
                                        Text("${index + 1}"),
                                        const Spacer(),
                                        Text(widget.lesson.recs[index].userName),
                                        const MySmallPadding(),
                                      ],
                                    ))
                          ],
                        ),
                      )),
                      sizeCurve: Curves.easeInOut,
                      crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 1200)),
                  const MySmallPadding(),
                ],
              ),
              // if ((widget.lesson.userRec != null && TODO: activate on release
              //     widget.lesson.userRec!.isOnline == false))
              // if (widget.lesson.userRec != null)
              //   Positioned(
              //     right: 16,
              //     top: 128,
              //     child: ,
              //   ),
              // if (widget.lesson.userRec != null)
              //   Positioned(
              //     right: 128,
              //     top: 140,
              //     child:
              //   ),
              // if (widget.lesson.userRec != null &&
              //     widget.lesson.userRec!.isOnline)
              //   Positioned(
              //     right: 96,
              //     top: 140,
              //     child:
              //   ),
              // if (widget.lesson.userRec != null &&
              //     !widget.lesson.userRec!.isOnline)
              //   Positioned(
              //     right: 96,
              //     top: 140,
              //     child:
              //   ),
            ])
            //   child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //     const MySmallPadding(),
            //     Flexible(
            //       child: Column(
            //         children: [
            //           const MySmallPadding(),
            //           SingleChildScrollView(
            //             scrollDirection: Axis.horizontal,
            //             child: Text(
            //               widget.lesson.displayName,
            //               style: Theme.of(context).textTheme.headlineSmall,
            //             ),
            //           ),
            //           const MySmallPadding(),
            //           Text(
            //             displayedRegState ? "Запись открыта" : "Запись закрыта",
            //             textAlign: TextAlign.center,
            //           ),
            //           if (!displayedRegState)
            //             TimerStartReg(widget.lesson.pair.startTime),
            //           const MySmallPadding(),
            //         ],
            //       ),
            //     ),
            //     const MySmallPadding(),
            //     if (displayedRegState)
            //       SizedBox(
            //         width: 148,
            //         child: Column(
            //             children: <Widget>[RecButton(widget.lesson)] +
            //                 ((widget.lesson.userRec != null)
            //                     ? <Widget>[const QrButton()]
            //                     : [])),
            //       ),
            //     const MySmallPadding(),
            //     AnimatedRotation(
            //       turns: expanded ? 0.5 : 0,
            //       duration: const Duration(milliseconds: 400),
            //       curve: Curves.easeInOut,
            //       child: const Icon(Icons.expand_more_outlined),
            //     ),
            //     const MySmallPadding(),
            //   ]),
            // ),
            ),
      ),
    );
  }
}
