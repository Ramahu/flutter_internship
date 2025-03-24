import 'package:flutter/material.dart';
import 'network/local/cache_helper.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool onboardingDone = CacheHelper.getData(key: 'onboarding_done') ?? false;
  runApp(MyApp(showOnboarding: !onboardingDone));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'intern app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: showOnboarding ? const OnboardingScreen() : const LoginScreen(),
    );
  }
}
