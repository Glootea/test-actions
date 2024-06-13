import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:queue/presentation/common_src/screen_headline.dart';
import 'package:queue/presentation/common_src/screen_padding.dart';

@RoutePage()
class ChooseSubjectScreen extends StatelessWidget {
  const ChooseSubjectScreen({required this.onTap, super.key});
  final void Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenPadding(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: ScreenHeadline(title: 'Выбор предмета', heroTag: 'Выбор предмета'),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 0,
                itemBuilder: (context, index) => const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
