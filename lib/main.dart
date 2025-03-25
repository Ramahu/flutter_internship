import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/network/local/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool onboardingDone = CacheHelper.getData(key: 'onboarding_done') ?? false;
  runApp(MyApp(showOnboarding: !onboardingDone));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.showOnboarding});
  final bool showOnboarding;

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter(showOnboarding);
    return MaterialApp.router(
      routerConfig: appRouter.router,
      title: 'intern app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // home: showOnboarding ? const OnboardingScreen() : const LoginScreen(),
    );
  }
}
