import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/page/login_screen.dart';
import '../../features/home_screen.dart';
import '../../features/onboarding/page/onboarding_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
}

class AppRouter {
  AppRouter(this.showOnboarding);
  final bool showOnboarding;

  late final GoRouter router = GoRouter(
    initialLocation: showOnboarding ? AppRoutes.onboarding : AppRoutes.login,
    navigatorKey: rootNavigatorKey,
    // debugLogDiagnostics: AppConfigs.routerLogger,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
