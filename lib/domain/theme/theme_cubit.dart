// ignore_for_file: require_trailing_commas

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
part 'theme_cubit.freezed.dart';

enum ThemePreset {
  dynamicTheme(Colors.transparent),
  white(
    Colors.white,
    'https://firebasestorage.googleapis.com/v0/b/queueminder.appspot.com/o/themes%2Fblack%2Fpanda.png?alt=media&token=5300bcff-1e05-4175-83a8-731fcda7ce19',
  ),
  green(Colors.green),
  blue(Colors.blue),
  red(Colors.red),
  paleBlue(Color(0xFF86E3CE)),
  paleGreen(Color(0xFFD0E6A5)),
  paleRed(Color(0xFFFA897B)),
  palePurple(Color(0xFFCCABD8)),
  // #D0E6A5 #FFDD94 #FA897B #CCABD8
  ;

  const ThemePreset(this.color, [this.backgroundImagePath]);

  final Color color;
  final String? backgroundImagePath;

  @override
  String toString() => name;

  static ThemePreset fromString(String name) {
    switch (name) {
      case 'defaultPreset':
        return ThemePreset.dynamicTheme;
      case 'white' || 'null':
        return ThemePreset.white;
      case 'green':
        return ThemePreset.green;
      case 'blue':
        return ThemePreset.blue;
      default:
        throw Exception('Unknown color theme: $name');
    }
  }

  bool get backgroundImagePossible => backgroundImagePath != null;
}

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required ThemePreset themePreset,
    required Brightness brightness,
    required bool showBackgroundImage,
  }) = _ThemeState;

  const ThemeState._();
  factory ThemeState.getDefault() =>
      const ThemeState(themePreset: ThemePreset.dynamicTheme, brightness: Brightness.dark, showBackgroundImage: true);

  ColorScheme? get getScheme => switch (themePreset) {
        ThemePreset.white => brightness == Brightness.light ? _whiteLightColorScheme : _whiteDarkColorScheme,
        ThemePreset.green => ColorScheme.fromSeed(seedColor: Colors.green, brightness: brightness),
        ThemePreset.blue => ColorScheme.fromSeed(seedColor: Colors.blue, brightness: brightness),
        _ => null
      };
}

const _whiteDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFE0E0E0), // Light gray
  onPrimary: Color(0xFF303030), // Dark gray
  secondary: Color(0xfffffef4), // Teal
  onSecondary: Color(0xFF303030), // Dark gray
  error: Color(0xFFCF6679), // Light red
  onError: Color(0xFF303030), // Dark gray
  surface: Color(0xFF121212), // Dark gray
  onSurface: Color(0xFFE0E0E0), // Light gray
  primaryContainer: Color(0xFF3D3D3D), // Light blue gray
  onPrimaryContainer: Color(0xFFD7D7D7), // Dark gray
  surfaceContainerLow: Color(0xFF1E1E1E), // Slightly lighter dark gray
);

const _whiteLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF424242), // Darker shade of grey
  onPrimary: Color(0xFFFFFFFF), // White
  secondary: Color(0xFF757575), // Medium shade of grey
  onSecondary: Color(0xFFFFFFFF), // White
  error: Color(0xFFD32F2F), // Muted red
  onError: Color(0xFFFFFFFF), // White
  surface: Color(0xFFF5F5F5), // Very light grey
  onSurface: Color(0xFF212121), // Almost black grey
  primaryContainer: Color(0xFF616161), // Slightly darker grey
  onPrimaryContainer: Color(0xFFFFFFFF), // White
  surfaceContainerLow: Color(0xFFE0E0E0), // Light grey
  outline: Color(0xFFBDBDBD), // Light grey for outline
  shadow: Color(0xFF000000), // Shadow color, typically black
  inverseSurface: Color(0xFF303030), // Dark grey for inverse surface
  onInverseSurface: Color(0xFFFFFFFF), // White on inverse surface
  inversePrimary: Color(0xFFFFFFFF), // Inverse primary for dark mode compatibility
);

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._keyValueStorage) : super(ThemeState.getDefault());
  final KeyValueStorage _keyValueStorage;

  Future<void> init() async {
    final (colorPreset, brightness, showBackgroundImage) =
        // ignore: inference_failure_on_untyped_parameter
        await (getColorPreset, getBrightness, getShowBackgroundImage).wait.catchError((e) {
      if (kDebugMode) {
        print('Theme cubit init error: $e');
      }
      return Future.value((ThemePreset.dynamicTheme, Brightness.dark, true));
    });
    if (kDebugMode) {
      print('Go cached: $colorPreset $brightness $showBackgroundImage');
    }
    await setTheme(themePreset: colorPreset, brightness: brightness, showBackgroundImage: showBackgroundImage);
  }

  Future<ThemePreset> get getColorPreset async {
    final storedValue = await _keyValueStorage.get(StoredValues.colorTheme);
    if (storedValue == null) {
      return ThemePreset.dynamicTheme;
    }
    return ThemePreset.fromString(storedValue);
  }

  Future<Brightness> get getBrightness async {
    final storedValue = await _keyValueStorage.get(StoredValues.brightness);
    if (storedValue == null) {
      return Brightness.dark;
    }
    return storedValue == Brightness.dark.toString() ? Brightness.dark : Brightness.light;
  }

  Future<bool> get getShowBackgroundImage async {
    final storedValue = await _keyValueStorage.get(StoredValues.showBackgroundImage);
    if (storedValue == null) {
      return true;
    }
    return storedValue == 'true';
  }

  Future<void> setTheme({ThemePreset? themePreset, Brightness? brightness, bool? showBackgroundImage}) async {
    brightness ??= state.brightness;
    themePreset ??= state.themePreset;
    showBackgroundImage ??= state.showBackgroundImage;

    emit(
      state.copyWith(
        themePreset: themePreset,
        brightness: brightness,
        showBackgroundImage: showBackgroundImage,
      ),
    );
    await _keyValueStorage.set(StoredValues.colorTheme, themePreset.toString());
    await _keyValueStorage.set(StoredValues.brightness, brightness.toString());
    await _keyValueStorage.set(StoredValues.showBackgroundImage, showBackgroundImage.toString());
  }
}
