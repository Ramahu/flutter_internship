import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern/core/keys/keys.dart';

import '../../../core/services/local_storage/cache_helper.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  build() {
    String savedLanguageCode = CacheHelper.getData(key: localeKey);
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;

    final code = savedLanguageCode.isEmpty
        ? deviceLocale.languageCode
        : savedLanguageCode;

    return Locale(code);
  }

  Future<void> setLocale(String code) async {
    state = Locale(code);
    await CacheHelper.saveData(key: localeKey, value: code);
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
