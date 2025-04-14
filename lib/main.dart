import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/network/local/cache_helper.dart';
import 'core/network/remote/cache_interceptor.dart';
import 'core/router/app_router.dart';
import 'core/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheInterceptor.init();
  await CacheHelper.init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'intern app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
    );
  }
}
