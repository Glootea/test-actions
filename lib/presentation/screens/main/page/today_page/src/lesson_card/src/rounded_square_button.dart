import 'package:flutter/material.dart';

/// If used in [Row] set crossAxisAlignment: [CrossAxisAlignment.stretch] it wrap [Row] with [IntrinsicHeight]
class RoundedSquareButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double size;
  final double borderRadius;
  const RoundedSquareButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.size,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: OutlinedButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}
