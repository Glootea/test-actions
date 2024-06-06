import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final size = MediaQuery.sizeOf(context).shortestSide;

    final loadingAnimation = ConstrainedBox(
      constraints: BoxConstraints.tight(Size(size / 2, size / 2)),
      child: LoadingAnimation(state: LoadingState.started, afterAnimationEnd: () {}),
    );

    final titleAndButtons = [
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
    ];

    final descriptionBlock = Padding(
      padding: const EdgeInsets.only(top: 32),
      child: ExpandableBlock(
        showDividers: false,
        isExpanded: selected != null,
        children: [
          if (selected == 0) const Text('Описание для учеников') else const Text('Описание для старост'),
        ],
      ),
    );

    final createGroupButton = Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Align(
        child: OutlinedButton(onPressed: () {}, child: const Text('Создать группу')),
      ),
    );

    final layout = (MediaQuery.sizeOf(context).aspectRatio > 1)
        ? [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: titleAndButtons),
                loadingAnimation,
              ],
            ),
            descriptionBlock,
            createGroupButton,
          ]
        : [loadingAnimation, ...titleAndButtons, descriptionBlock, createGroupButton];

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
