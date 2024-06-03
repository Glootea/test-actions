import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class GoToTile extends StatelessWidget {
  const GoToTile({required this.title, required this.route, this.heroTag, super.key});
  final PageRouteInfo<void> route;
  final String title;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: heroTag != null
          ? Hero(tag: heroTag!, child: Text(title, style: Theme.of(context).textTheme.bodyLarge))
          : Text(title),
      trailing: const Icon(Icons.north_east_outlined),
      onTap: () => AutoRouter.of(context).push(route),
    );
  }
}
