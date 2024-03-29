import 'package:flutter/material.dart';

class ExpandButton extends StatelessWidget {
  const ExpandButton(this.expanded, {super.key});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
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
    );
  }
}
