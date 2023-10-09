import 'dart:async';
import 'package:flutter/material.dart';
import 'package:queue/models/lesson.dart';
import 'package:queue/models/rec.dart';
import 'package:queue/presentation/widgets/padding.dart';
import 'package:queue/presentation/widgets/qr_button.dart';
import 'package:queue/presentation/widgets/rec_button.dart';
import 'package:queue/presentation/widgets/timer_start_reg.dart';
import 'package:intl/intl.dart';

class LessonWidget extends StatefulWidget {
  final Lesson lesson;
  const LessonWidget(this.lesson, {super.key});

  @override
  State<LessonWidget> createState() => _LessonWidgetState();
}

class _LessonWidgetState extends State<LessonWidget> {
  DateTime get now => DateTime.now();
  TimeOfDay timerStartDelay = const TimeOfDay(minute: 11, hour: 0);

  late bool displayedRegState;

  bool get regIsActive => (timeToStart < timerStartDelay &&
      const TimeOfDay(hour: 0, minute: 0) < timetillEnd);
  bool get showTimer =>
      timeToStart < const TimeOfDay(hour: 0, minute: 30) &&
      timerStartDelay < timeToStart;
  TimeOfDay get timeToStart =>
      widget.lesson.pair.startTime - TimeOfDay.fromDateTime(now);
  TimeOfDay get timetillEnd =>
      widget.lesson.pair.endTime - TimeOfDay.fromDateTime(now);

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
    List<Rec> sortedList = widget.lesson.recs
      ..sort((a, b) => a.time.isBefore(b.time) ? -1 : 1);
    int queueN = sortedList
            .indexOf(widget.lesson.userRec ?? Rec('none', DateTime.now())) +
        1;
    return GestureDetector(
        onTap: () => setState(() {
              expanded = !expanded;
            }),
        child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 1200),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).colorScheme.primaryContainer),
            child: Stack(children: [
              Column(
                children: [
                  const MySmallPadding(),
                  Row(
                    children: [
                      const MySmallPadding(),
                      Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            widget.lesson.displayName,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                      const MyPadding(),
                      AnimatedRotation(
                        turns: expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: const Icon(Icons.expand_more_outlined),
                      ),
                      const MySmallPadding(),
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
                                          displayedRegState
                                              ? "Запись открыта"
                                              : "Запись закрыта",
                                          textAlign: TextAlign.left,
                                        )
                                      : TimerStartReg(
                                          widget.lesson.pair.startTime)
                                  : Text(
                                      "Запись от\n${DateFormat('yyyy-MM-dd в kk:mm:ss').format(widget.lesson.userRec!.time)}")),
                        ),
                        const Spacer(),
                        if (displayedRegState || widget.lesson.userRec != null)
                          SizedBox(height: 40, child: RecButton(widget.lesson)),
                        const MySmallPadding(),
                      ],
                    ),
                  ),
                  const MySmallPadding(),
                  if (widget.lesson.userRec != null)
                    Row(
                      children: [
                        const MySmallPadding(),
                        Text(
                          queueN == 0
                              ? "Очередь не синхронизирована"
                              : "Вы $queueN в очереди",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
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
                                itemCount: sortedList.length,
                                itemBuilder: (context, index) => Row(
                                      children: [
                                        const MySmallPadding(),
                                        Text("${index + 1}"),
                                        const Spacer(),
                                        Text(sortedList[index].userName),
                                        const MySmallPadding(),
                                      ],
                                    ))
                          ],
                        ),
                      )),
                      sizeCurve: Curves.easeInOut,
                      crossFadeState: expanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 1200)),
                  const MySmallPadding(),
                ],
              ),
              // if ((widget.lesson.userRec != null && TODO: activate on release
              //     widget.lesson.userRec!.isOnline == false))
              if (widget.lesson.userRec != null)
                Positioned(
                  right: 16,
                  top: 128,
                  child: SizedBox(
                      height: 40, child: QrButton(widget.lesson.tableName)),
                ),
              if (widget.lesson.userRec != null)
                Positioned(
                  right: 128,
                  top: 140,
                  child: Icon(
                    Icons.save_outlined,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              if (widget.lesson.userRec != null &&
                  widget.lesson.userRec!.isOnline)
                Positioned(
                  right: 96,
                  top: 140,
                  child: Icon(
                    Icons.wifi_outlined,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              if (widget.lesson.userRec != null &&
                  !widget.lesson.userRec!.isOnline)
                Positioned(
                  right: 96,
                  top: 140,
                  child: Icon(
                    Icons.wifi_off_outlined,
                    size: 20,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
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
            ));
  }
}

extension TimeArithmetic on TimeOfDay {
  TimeOfDay operator -(TimeOfDay other) {
    int totalMinutes = (hour - other.hour) * 60 + (minute - other.minute);
    if (totalMinutes <= 0) return const TimeOfDay(hour: 0, minute: 0);
    return TimeOfDay(hour: totalMinutes ~/ 60, minute: totalMinutes % 60);
  }

  bool operator <(TimeOfDay other) {
    if (hour < other.hour) return true;
    if (hour > other.hour) return false;
    if (minute < other.minute) return true;
    return false;
  }

  bool operator <=(TimeOfDay other) {
    if (hour <= other.hour) return true;
    if (hour > other.hour) return false;
    if (minute <= other.minute) return true;
    return false;
  }
}
