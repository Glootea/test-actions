import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/domain/theme_cubit.dart';

class TodayLessonsEndDrawer extends StatelessWidget {
  const TodayLessonsEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      Text("Тема", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
      const Gap(16),
      ThemePicker()
    ];
    return SafeArea(
        child: Drawer(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(itemCount: children.length, itemBuilder: (context, index) => children[index]),
    )));
  }
}

class ThemePicker extends StatelessWidget {
  const ThemePicker({
    super.key,
  });
  bool isModeToggle(ThemePreset e) => e.name == ThemePreset.defaultPreset.name;
  @override
  Widget build(BuildContext context) {
    const double colorPickerCircleSize = 16;
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      print(state);
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ThemePreset.values.map((e) {
            final colorScheme = e.color;
            final selected = e.name == state.themePreset.name;
            return GestureDetector(
              onTap: () => context.read<ThemeCubit>().setTheme(themePreset: e, brightness: state.brightness),
              child: Container(
                height: colorPickerCircleSize,
                width: colorPickerCircleSize,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme,
                    border: selected ? Border.all(color: Theme.of(context).colorScheme.onSurface) : null),
                child: switch ((e, state.brightness)) {
                  (ThemePreset.defaultPreset, Brightness.light) =>
                    const Icon(Icons.light_mode_outlined, size: colorPickerCircleSize),
                  (ThemePreset.defaultPreset, Brightness.dark) =>
                    const Icon(Icons.dark_mode_outlined, size: colorPickerCircleSize),
                  _ => Container(),
                },
              ),
            );
          }).toList());
    });
  }
}
