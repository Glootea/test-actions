import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queue/navigation.dart';
import 'package:queue/presentation/common_src/expandable_block.dart';
import 'package:queue/presentation/common_src/loading/queue_loading_container.dart';
import 'package:queue/presentation/common_src/screen_headline.dart';
import 'package:queue/presentation/common_src/screen_padding.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int? selected = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).shortestSide - 32;

    final loadingAnimation = ConstrainedBox(
      constraints: BoxConstraints.tight(Size(size / 2, size / 2)),
      child: LoadingAnimation(state: LoadingState.started, afterAnimationEnd: () {}),
    );
    final createGroupButton = Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Align(
        child: OutlinedButton(
          onPressed: () async => AutoRouter.of(context).popAndPush(const InitLoadingRoute()),
          child: const Text('Войти'),
        ),
      ),
    );
    final titleAndButtons = <Widget>[
      const Align(child: ScreenHeadline(title: 'QueueMinder', heroTag: 'title')),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceChip(
            label: const Text('Ученикам'),
            selected: selected == 0,
            onSelected: (value) => setState(() {
              value ? selected = 0 : selected = null;
            }),
          ),
          const Gap(16),
          ChoiceChip(
            label: const Text('Старостам'),
            selected: selected == 1,
            onSelected: (value) => setState(() {
              value ? selected = 1 : selected = null;
            }),
          ),
        ],
      ),
      if (selected == 1) createGroupButton,
    ];

    final descriptionBlock = Padding(
      padding: const EdgeInsets.only(top: 32),
      child: ExpandableBlock(
        showDividers: false,
        isExpanded: selected != null,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              (selected != 1)
                  ? 'Единственным способом входа является ссылка, выданная старостой.\n\nЕсли вы хотите создать свою группу, перейдите в раздел старост.\n'
                  : 'Данные хранятся на Google Drive, для этого требуется авторизация.\n\n\n',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('''
Приложение для управления очередями сдачи работ на парах и отслеживания дедлайнов.
Возможности:
  • создание очередей по расписанию
  • отслеживание количества сданных работ и учет данного фактора при составлении очереди
  • интеграция с календарем для уведомлений, отслеживания заданий и их выполнения к дедлайну
  '''),
          ),
        ],
      ),
    );

    final layout = (MediaQuery.sizeOf(context).aspectRatio > 1)
        ? [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(size / 2, size / 2)),
                  child: ListView(shrinkWrap: true, children: <Widget>[const SizedBox(height: 64)] + titleAndButtons),
                ),
                loadingAnimation,
              ],
            ),
            descriptionBlock,
            const Gap(16),
          ]
        : [
            loadingAnimation,
            ...titleAndButtons,
            descriptionBlock,
            createGroupButton,
            const Gap(16),
          ];

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: ScreenPadding(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) => layout[index],
            itemCount: layout.length,
          ),
        ),
      ),
    );
  }
}
