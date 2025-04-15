import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern/core/localization_notifier.dart';

import 'core/network/local/cache_helper.dart';
import 'core/router/app_router.dart';
import 'core/theme_notifier.dart';
import 'core/util/storage_keys.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  final savedLangCode = CacheHelper.getData(key: localeKey);

  runApp(ProviderScope(overrides: [
    languageProvider.overrideWith((ref) {
      if (savedLangCode != null) {
        return LanguageNotifier(); 
      } else {
        // Use device locale on first install
        final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
        final notifier = LanguageNotifier();
        notifier.setLocale(deviceLocale.languageCode);
        return notifier;
      }
    }),
  ], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(languageProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'School app',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      locale: locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
    );
  }
}
