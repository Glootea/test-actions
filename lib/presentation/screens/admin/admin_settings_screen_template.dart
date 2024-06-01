import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/presentation/common_src/screen_headline.dart';

class AdminSettingsScreenTemplate extends StatelessWidget {
  const AdminSettingsScreenTemplate({
    required this.children,
    required this.onSubmit,
    required this.title,
    required this.headlineHeroTag,
    super.key,
  });

  final List<Widget> children;
  final String title;
  final String headlineHeroTag;
  final Future<void> Function() onSubmit;
  @override
  Widget build(BuildContext context) {
    final items = [ScreenHeadline(title: title, heroTag: headlineHeroTag), const Gap(32), ...children];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: children.length + 2,
                itemBuilder: (context, index) => items[index],
              ),
            ),
          ),
          ColoredBox(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment:
                    MediaQuery.sizeOf(context).width > 600 ? MainAxisAlignment.end : MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: AutoRouter.of(context).maybePop,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.errorContainer),
                    ),
                    child: Text(
                      'Отмена',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.onErrorContainer),
                    ),
                  ),
                  const Gap(16),
                  OutlinedButton(
                    onPressed: onSubmit,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).colorScheme.onPrimaryContainer),
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
                    ),
                    child: Text('Применить', style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
