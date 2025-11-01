import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/strings.dart';
import '../helpers/sharedpref_helper.dart';
import 'theme_app_state.dart';

enum AppTheme { light, dark, system }

class ThemeAppCubit extends Cubit<ThemeAppState> {
  ThemeAppCubit() : super(AppInitialState()) {
    _loadTheme();
  }
  AppTheme currentTheme = AppTheme.system;
  Future<void> selectAppTheme(AppTheme theme) async {
    currentTheme = theme;
    await SharedprefHelper.setData("Theme", currentTheme.name);
    await SharedprefHelper.setBoolData("isDark", isDark);
    emit(AppChangedTheme());
  }

  ThemeMode get getTheme {
    logger.d("Getting theme for: $currentTheme");
    switch (currentTheme) {
      case AppTheme.light:
        return ThemeMode.light;
      case AppTheme.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> _loadTheme() async {
    final themeName = SharedprefHelper.getData("Theme");
    isDark = SharedprefHelper.getBoolData("isDark") ?? false;
    logger.d("Loaded theme from prefs: $themeName");
    logger.d(isDark);
    if (themeName != null) {
      currentTheme = AppTheme.values.firstWhere(
        (e) => e.name == themeName,
        orElse: () => AppTheme.system,
      );
    }
    emit(AppChangedTheme());
  }
}
