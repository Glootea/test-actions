import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/domain/theme/theme_cubit.dart';
import 'package:queue/domain/user/user_cubit.dart';
import 'package:queue/presentation/common_src/defined_text.dart';
import 'package:queue/presentation/common_src/expandable_block.dart';
import 'package:queue/presentation/common_src/toggle_row.dart';

class TodayLessonsEndDrawer extends StatelessWidget {
  const TodayLessonsEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final children = [
      const H2('Тема'),
      BlocSelector<ThemeCubit, ThemeState, Brightness>(
        builder: (context, state) => ToggleRow(
          text: 'Темная тема: ',
          onChanged: (_) =>
              themeCubit.setTheme(brightness: state == Brightness.dark ? Brightness.light : Brightness.dark),
          initialValue: state == Brightness.dark,
        ),
        selector: (state) => state.brightness,
      ),
      ExpandableBlock(
        isExpanded: !kIsWeb && (Platform.isAndroid || Platform.isLinux || Platform.isMacOS || Platform.isWindows),
        showDividers: false,
        children: [
          BlocSelector<ThemeCubit, ThemeState, ThemePreset>(
            selector: (state) => state.themePreset,
            builder: (context, state) => ToggleRow(
              text: 'Динамическая тема: ',
              onChanged: (value) =>
                  themeCubit.setTheme(themePreset: value ? ThemePreset.dynamicTheme : ThemePreset.white),
              initialValue: state == ThemePreset.dynamicTheme,
            ),
          ),
        ],
      ),
      BlocSelector<ThemeCubit, ThemeState, bool>(
        selector: (state) => state.themePreset != ThemePreset.dynamicTheme,
        builder: (context, state) => ExpandableBlock(
          isExpanded: state,
          showDividers: false,
          children: const [
            Align(
              alignment: Alignment.centerLeft,
              child: H3('Цветовая тема: '),
            ),
            ThemeColorPicker(),
          ],
        ),
      ),
      BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) => ExpandableBlock(
          isExpanded: state.themePreset.backgroundImagePossible,
          showDividers: false,
          children: [
            ToggleRow(
              text: 'Изображение на фоне: ',
              onChanged: (value) => themeCubit.setTheme(showBackgroundImage: value),
              initialValue: themeCubit.state.showBackgroundImage,
            ),
          ],
        ),
      ),
      const Divider(),
      OutlinedButton(
        onPressed: () => context.read<UserCubit>().login(name: 'Sasha', isAdmin: false, rowNumber: 1),
        child: const Text('Войти'),
      ),
      OutlinedButton(
        onPressed: () => context.read<UserCubit>().login(name: 'Sasha', isAdmin: true, rowNumber: 1),
        child: const Text('Войти админ'),
      ),
      OutlinedButton(onPressed: () => context.read<UserCubit>().logout(), child: const Text('Выйти')),
    ];
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(itemCount: children.length, itemBuilder: (context, index) => children[index]),
        ),
      ),
    );
  }
}

class ThemeColorPicker extends StatelessWidget {
  const ThemeColorPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final children = ThemePreset.values
            .where((preset) => preset != ThemePreset.dynamicTheme)
            .map((preset) => _ColorPickerItem(preset, state))
            .toList();
        return GridView.builder(
          itemCount: children.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemBuilder: (context, index) => Center(child: children[index]),
        );
      },
    );
  }
}

class _ColorPickerItem extends StatelessWidget {
  const _ColorPickerItem(this.preset, this.state);
  final ThemePreset preset;
  final ThemeState state;

  @override
  Widget build(BuildContext context) {
    final color = preset.color;
    final selected = preset.name == state.themePreset.name;
    return _ThemePickerItem(
      onTap: () => context.read<ThemeCubit>().setTheme(
            themePreset: preset,
            brightness: state.brightness,
          ),
      selected: selected,
      child: Container(color: color),
    );
  }
}

// class _BrightnessToggleItem extends StatelessWidget {
//   const _BrightnessToggleItem(this.state);
//   final ThemeState state;

//   @override
//   Widget build(BuildContext context) {
//     return _ThemePickerItem(
//       onTap: () => context
//           .read<ThemeCubit>()
//           .setTheme(brightness: (state.brightness == Brightness.dark) ? Brightness.light : Brightness.dark),
//       selected: false,
//       child: switch (state.brightness) {
//         Brightness.light => const Icon(Icons.light_mode_outlined),
//         Brightness.dark => const Icon(Icons.dark_mode_outlined)
//       },
//     );
//   }
// }

class _ThemePickerItem extends StatelessWidget {
  const _ThemePickerItem({
    required this.child,
    required this.selected,
    required this.onTap,
  });

  final bool selected;
  final Widget child;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    const colorPickerCircleSize = 32.0;
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
                  color: Theme.of(context).colorScheme.onSurface,
                )
              : null,
        ),
        child: child,
      ),
    );
  }
}
