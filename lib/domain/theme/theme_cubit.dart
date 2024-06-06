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
  primary: Colors.white,
  onPrimary: Colors.black,
  secondary: Colors.black87,
  onSecondary: Colors.black,
  error: Colors.redAccent,
  onError: Colors.redAccent,
  surface: Colors.black54,
  onSurface: Colors.white,
  primaryContainer: Colors.black,
  onPrimaryContainer: Colors.white,
);

const _whiteLightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.black,
  onPrimary: Colors.white,
  secondary: Colors.black,
  onSecondary: Colors.white,
  error: Colors.redAccent,
  onError: Colors.redAccent,
  surface: Colors.white,
  onSurface: Colors.black,
  primaryContainer: Colors.white,
  onPrimaryContainer: Colors.black,
  surfaceContainerLow: Colors.white60,
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
