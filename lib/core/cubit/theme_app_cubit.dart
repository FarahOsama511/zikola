import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zikola/core/cubit/theme_app_state.dart';

import '../helpers/sharedpref_helper.dart';

enum AppTheme { light, dark, system }

class ThemeAppCubit extends Cubit<ThemeAppState> {
  ThemeAppCubit() : super(AppInitialState()) {
    _loadTheme();
  }
  AppTheme currentTheme = AppTheme.system;
  Future<void> selectAppTheme(AppTheme theme) async {
    currentTheme = theme;
    await SharedprefHelper.setData("Theme", currentTheme.name);
    emit(AppChangedTheme());
  }

  ThemeMode get getTheme {
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
    if (themeName != null) {
      currentTheme = AppTheme.values.firstWhere(
        (e) => e.name == themeName,
        orElse: () => AppTheme.system,
      );
    }
    emit(AppChangedTheme());
  }
}
