import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/presentation/common_src/defined_text.dart';

class ScreenHeadline extends StatelessWidget {
  const ScreenHeadline({
    required this.title,
    required this.heroTag,
    super.key,
  });

  final String heroTag;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AutoRouter.of(context).maybePop(),
      child: Hero(
        tag: heroTag,
        child: H1(title),
      ),
    );
  }
}
