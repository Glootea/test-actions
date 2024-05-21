import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
part 'theme_cubit.freezed.dart';

enum ThemePreset {
  defaultPreset(Colors.transparent),
  white(Colors.white),
  green(Colors.green),
  blue(Colors.blue),
  red(Colors.red),
  paleBlue(Color(0xFF86E3CE)),
  paleGreen(Color(0xFFD0E6A5)),
  paleRed(Color(0xFFFA897B)),
  palePurple(Color(0xFFCCABD8)),
  // #D0E6A5 #FFDD94 #FA897B #CCABD8
  ;

  final Color color;

  const ThemePreset(this.color);
  @override
  String toString() => name;

  static ThemePreset fromString(String name) {
    switch (name) {
      case 'defaultPreset':
        return ThemePreset.defaultPreset;
      case 'white':
        return ThemePreset.white;
      case 'green':
        return ThemePreset.green;
      case 'blue':
        return ThemePreset.blue;
      default:
        throw Exception('Unknown color theme $name');
    }
  }
}

@freezed
class ThemeState with _$ThemeState {
  const ThemeState._();
  const factory ThemeState({
    required ThemePreset themePreset,
    required Brightness brightness,
  }) = _ThemeState;
  static ThemeState getDefault() =>
      const ThemeState(themePreset: ThemePreset.defaultPreset, brightness: Brightness.dark);

  String? get getBackgroundImagePath => switch (themePreset) {
        ThemePreset.defaultPreset => null,
        _ => null,
      };
  ColorScheme? get getScheme => switch (themePreset) {
        ThemePreset.white => ColorScheme.fromSeed(seedColor: Colors.white, brightness: brightness),
        ThemePreset.green => ColorScheme.fromSeed(seedColor: Colors.green, brightness: brightness),
        ThemePreset.blue => ColorScheme.fromSeed(seedColor: Colors.blue, brightness: brightness),
        _ => null
      };
}

class ThemeCubit extends Cubit<ThemeState> {
  final KeyValueStorage _keyValueStorage;
  ThemeCubit(this._keyValueStorage) : super(ThemeState.getDefault()) {
    _init();
  }

  Future<void> _init() async {
    final (colorPreset, brightness) = await (getColorPreset, getBrightness).wait;
    print("Go cached: $colorPreset $brightness");
    setTheme(themePreset: colorPreset, brightness: brightness);
  }

  Future<ThemePreset> get getColorPreset async {
    final storedValue = await _keyValueStorage.get(StoredValues.colorTheme);
    if (storedValue == null) {
      return ThemePreset.defaultPreset;
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

  void setTheme({ThemePreset? themePreset, Brightness? brightness}) async {
    brightness ??= state.brightness;
    // themePreset = ((ThemePreset.defaultPreset == themePreset) ? state.themePreset : themePreset);
    emit(state.copyWith(
      themePreset: themePreset ?? state.themePreset,
      brightness: brightness,
    ));
    print(brightness);
    await _keyValueStorage.set(StoredValues.colorTheme, themePreset.toString());
    await _keyValueStorage.set(StoredValues.brightness, brightness.toString());
  }

  // static const _colorTheme = ColorScheme(
  //     brightness: Brightness.dark,
  //     primary: Colors.white,
  //     onPrimary: Colors.black,
  //     secondary: Colors.grey,
  //     onSecondary: Colors.black,
  //     error: Colors.red,
  //     onError: Colors.redAccent,
  //     background: Colors.black,
  //     onBackground: Colors.white,
  //     surface: Colors.black38,
  //     onSurface: Colors.white,
  //     primaryContainer: Colors.black,
  //     onPrimaryContainer: Colors.white);
}
