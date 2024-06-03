import 'package:flutter/material.dart';

class ExpandableBlock extends StatelessWidget {
  const ExpandableBlock({required this.children, required this.isExpanded, this.showDividers = true, super.key});
  final List<Widget> children;
  final bool isExpanded;
  final bool showDividers;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300 * children.length),
      alignment: Alignment.topCenter,
      child: isExpanded
          ? Column(
              children: [
                if (showDividers) const Divider(),
                ...children,
                if (showDividers) const Divider(),
              ],
            )
          : Container(),
    );
  }
}
