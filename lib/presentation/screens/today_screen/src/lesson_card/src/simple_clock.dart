import 'dart:math';

import 'package:flutter/material.dart';

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
                time: startTime,
                radius: size,
                color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.6)),
            size: Size(size, size)));
  }
}

class _SimpleClockPainter extends CustomPainter {
  final DateTime time;
  final double radius;
  final Color color;
  const _SimpleClockPainter({required this.time, required this.radius, required this.color});

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
    final hourX = center.dx + radius * cos(time.hour % 12 / 12 * 2 * pi - pi / 2) / 1.5;
    final hourY = center.dy + radius * sin(time.hour % 12 / 12 * 2 * pi - pi / 2) / 1.5;
    final minuteX = center.dx + radius * cos(time.minute / 60 * 2 * pi - pi / 2) / 1.2;
    final minuteY = center.dy + radius * sin(time.minute / 60 * 2 * pi - pi / 2) / 1.2;
    canvas.drawLine(center, Offset(hourX, hourY), paint);
    canvas.drawLine(center, Offset(minuteX, minuteY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
