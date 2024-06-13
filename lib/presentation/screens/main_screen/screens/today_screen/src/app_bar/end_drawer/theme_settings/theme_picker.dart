import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/domain/theme/theme_cubit.dart';
import 'package:queue/domain/theme/theme_state.dart';

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
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 80),
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
