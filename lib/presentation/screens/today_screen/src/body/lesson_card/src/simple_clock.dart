import 'dart:math';
import 'package:flutter/material.dart';

class CountDownClock extends StatefulWidget {
  final DateTime expireTime;
  final DateTime startTime;
  final double size;
  final VoidCallback onEnd;
  CountDownClock({required this.expireTime, DateTime? startTime, required this.size, required this.onEnd, super.key})
      : startTime = startTime ?? expireTime.subtract(const Duration(hours: 1));

  @override
  State<CountDownClock> createState() => _CountDownClockState();
}

class _CountDownClockState extends State<CountDownClock> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final timeLeft = widget.expireTime.difference(DateTime.now());
    final duration = widget.expireTime.difference(widget.startTime);

    return TweenAnimationBuilder<Duration>(
        onEnd: widget.onEnd,
        tween: Tween(begin: timeLeft, end: Duration.zero),
        duration: timeLeft,
        builder: (context, value, child) {
          final actualTimeLeft = widget.expireTime.difference(DateTime.now());
          return Padding(
              padding: EdgeInsets.only(right: widget.size / 2),
              child: CustomPaint(
                  painter: _SimpleClockPainter(
                      outerValue: actualTimeLeft.inMinutes / 60,
                      innerValue: actualTimeLeft.inSeconds / 60,
                      radius: widget.size,
                      color: Color.lerp(
                        Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6),
                        Theme.of(context).colorScheme.error,
                        Curves.easeInQuad.transform(1 - (actualTimeLeft.inSeconds / duration.inSeconds)),
                      )!),
                  size: Size(widget.size, widget.size)));
        });
  }
}

class SimpleClock extends StatelessWidget {
  const SimpleClock({
    super.key,
    required this.startTime,
    required this.size,
  });

  final DateTime startTime;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: size / 2),
        child: CustomPaint(
            painter: _SimpleClockPainter(
                outerValue: (startTime.hour % 12 + startTime.minute / 60) / 12,
                innerValue: startTime.minute / 60,
                // time: startTime,
                radius: size,
                color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6)),
            size: Size(size, size)));
  }
}

class _SimpleClockPainter extends CustomPainter {
  /// Normalized value that corresponds to the shorter arrow of the clock
  final double outerValue;

  /// Normalized value that corresponds to the longer arrow of the clock
  final double innerValue;
  final double radius;
  final Color color;
  const _SimpleClockPainter(
      {required this.outerValue, required this.innerValue, required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..blendMode = BlendMode.src
      ..strokeWidth = 4;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint..style = PaintingStyle.stroke);
    final hourX = center.dx + radius * cos((outerValue % 1) * 2 * pi - pi / 2) / 1.5;
    final hourY = center.dy + radius * sin((outerValue % 1) * 2 * pi - pi / 2) / 1.5;
    final minuteX = center.dx + radius * cos((innerValue % 1) * 2 * pi - pi / 2) / 1.2;
    final minuteY = center.dy + radius * sin((innerValue % 1) * 2 * pi - pi / 2) / 1.2;
    canvas.drawLine(center, Offset(hourX, hourY), paint);
    canvas.drawLine(center, Offset(minuteX, minuteY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
