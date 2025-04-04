import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/network/local/cache_helper.dart';
import 'core/router/app_router.dart';
import 'core/theme_notifier.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  bool onboardingDone = CacheHelper.getData(key: 'onboarding_done') ?? false;

  runApp(ProviderScope(
      child: MyApp(showOnboarding: !onboardingDone)
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key, required this.showOnboarding});
  final bool showOnboarding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppRouter appRouter = AppRouter(showOnboarding,ref);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: appRouter.router,
      title: 'intern app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
    );
  }
}
