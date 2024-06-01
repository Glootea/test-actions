import 'package:flutter/material.dart';

class ExpandableBlock extends StatelessWidget {
  const ExpandableBlock({required this.children, required this.isExpanded, super.key});
  final List<Widget> children;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300 * children.length),
      alignment: Alignment.topCenter,
      child: isExpanded
          ? Column(
              children: [
                const Divider(),
                ...children,
                const Divider(),
              ],
            )
          : Container(),
    );
  }
}
