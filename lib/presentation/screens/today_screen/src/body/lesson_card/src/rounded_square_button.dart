import 'package:flutter/material.dart';

class RoundedSquareButton extends StatelessWidget {
  const RoundedSquareButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor = Colors.transparent,
  });
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 64,
        width: 64,
        child: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.outline.withOpacity(0.8),
              ),
            ),
          ),
          icon: Icon(
            icon,
            color: Theme.of(context).textTheme.bodyLarge?.color,
            size: 24,
          ),
          onPressed: onTap,
          // onPressed: () {

          // }),
        ));
  }
}
