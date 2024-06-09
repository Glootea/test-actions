import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue/data/database/sources/local_database/local_database.dart';
import 'package:queue/domain/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit._(this._keyValueStorage) : super(ThemeState.getDefault());
  final KeyValueStorage _keyValueStorage;
  static Future<ThemeCubit> create(KeyValueStorage storage) async {
    final cubit = ThemeCubit._(storage);
    await cubit._init();
    return cubit;
  }

  Future<void> _init() async {
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
