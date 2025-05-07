import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/keys/keys.dart';
import '../../../core/services/local_storage/cache_helper.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    bool isDarkMode = CacheHelper.getData(key: darkModeKey) ?? false;
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    bool isDark = state == ThemeMode.dark;
    await CacheHelper.saveData(key: darkModeKey, value: !isDark);
    state = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
