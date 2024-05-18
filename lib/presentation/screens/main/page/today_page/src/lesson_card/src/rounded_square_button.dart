import 'package:flutter/material.dart';

class LessonCardButton extends StatelessWidget {
  const LessonCardButton({
    super.key,
    required this.icon,
    required this.onTap,
  });
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 64,
        width: 64,
        child: IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.outline,
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
