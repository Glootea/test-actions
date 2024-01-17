import 'dart:ui';

import 'package:flutter/widgets.dart';

class BluredBox extends StatelessWidget {
  const BluredBox({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: child,
    ));
  }
}
