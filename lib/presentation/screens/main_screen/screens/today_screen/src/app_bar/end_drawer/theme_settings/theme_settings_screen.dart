import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/domain/theme/theme_cubit.dart';
import 'package:queue/domain/theme/theme_state.dart';
import 'package:queue/presentation/common_src/defined_text.dart';
import 'package:queue/presentation/common_src/expandable_block.dart';
import 'package:queue/presentation/common_src/screen_headline.dart';
import 'package:queue/presentation/common_src/screen_padding.dart';
import 'package:queue/presentation/common_src/toggle_row.dart';
import 'package:queue/presentation/screens/main_screen/screens/today_screen/src/app_bar/end_drawer/theme_settings/theme_picker.dart';

@RoutePage()
class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicThemeAvailable =
        !kIsWeb && (Platform.isAndroid || Platform.isLinux || Platform.isMacOS || Platform.isWindows);
    final themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      body: ScreenPadding(
        child: ListView(
          children: [
            const ScreenHeadline(title: 'Настройки темы', heroTag: 'Настройки темы'),
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
              isExpanded: dynamicThemeAvailable,
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
                isExpanded: !dynamicThemeAvailable || state,
                showDividers: false,
                children: const [
                  Divider(),
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
          ],
        ),
      ),
    );
  }
}
