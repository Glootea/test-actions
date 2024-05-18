import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:queue/domain/theme/theme_cubit.dart';
import 'package:queue/domain/user/user_cubit.dart';

class TodayLessonsEndDrawer extends StatelessWidget {
  const TodayLessonsEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      Text("Тема", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
      const Gap(16),
      const ThemePicker(),
      OutlinedButton(
          onPressed: () => context.read<UserCubit>().login(name: "Sasha", isAdmin: false, rowNumber: 1),
          child: const Text("Войти")),
      OutlinedButton(
          onPressed: () => context.read<UserCubit>().login(name: "Sasha", isAdmin: true, rowNumber: 1),
          child: const Text("Войти админ")),
      OutlinedButton(onPressed: () => context.read<UserCubit>().logout(), child: const Text("Выйти"))
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
  List<Widget> _getChildren(BuildContext context, ThemeState state) =>
      <Widget>[_BrightnessToggleItem(state)] +
      ThemePreset.values.map((preset) => _ColorPickerItem(preset, state)).toList();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      final children = _getChildren(context, state);
      return GridView.builder(
        itemCount: children.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (context, index) => Center(child: children[index]),
      );
    });
  }
}

class _ColorPickerItem extends StatelessWidget {
  final ThemePreset preset;
  final ThemeState state;
  const _ColorPickerItem(this.preset, this.state);

  @override
  Widget build(BuildContext context) {
    final color = preset.color;
    final selected = preset.name == state.themePreset.name;
    return _ThemePickerItem(
        onTap: () => context.read<ThemeCubit>().setTheme(themePreset: preset, brightness: state.brightness),
        selected: selected,
        child: (color == Colors.transparent) ? const Center(child: Text("D")) : Container(color: color));
  }
}

class _BrightnessToggleItem extends StatelessWidget {
  final ThemeState state;
  const _BrightnessToggleItem(this.state);

  @override
  Widget build(BuildContext context) {
    return _ThemePickerItem(
        onTap: () => context
            .read<ThemeCubit>()
            .setTheme(brightness: (state.brightness == Brightness.dark) ? Brightness.light : Brightness.dark),
        selected: false,
        child: switch (state.brightness) {
          Brightness.light => const Icon(Icons.light_mode_outlined),
          Brightness.dark => const Icon(Icons.dark_mode_outlined)
        });
  }
}

class _ThemePickerItem extends StatelessWidget {
  const _ThemePickerItem({required this.child, required this.selected, required this.onTap});

  final bool selected;
  final Widget child;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    const double colorPickerCircleSize = 32;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: colorPickerCircleSize,
        width: colorPickerCircleSize,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: selected
                ? Border.all(
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Theme.of(context).colorScheme.onSurface)
                : null),
        child: child,
      ),
    );
  }
}
