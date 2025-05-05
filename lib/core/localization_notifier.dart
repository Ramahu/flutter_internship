import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern/core/keys/keys.dart';

import 'services/local_storage/cache_helper.dart';

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    String langCode = CacheHelper.getData(key: localeKey) ?? 'en';
    state = Locale(langCode);
  }

  Future<void> setLocale(String code) async {
    state = Locale(code);
    await CacheHelper.saveData(key: localeKey, value: code);
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>(
  (ref) => LanguageNotifier(),
);
