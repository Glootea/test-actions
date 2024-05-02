import 'package:flutter/material.dart';

/// If used in [Row] set crossAxisAlignment: [CrossAxisAlignment.stretch] it wrap [Row] with [IntrinsicHeight]
class RoundedSquareButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  const RoundedSquareButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}
