import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/page/login_screen.dart';
import '../../features/auth/provider/auth_notifier.dart';
import '../../features/home_screen.dart';
import '../../features/onboarding/page/onboarding_screen.dart';
import '../enums/auth_status.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter(this.showOnboarding,this.ref);
  final bool showOnboarding;
  final WidgetRef ref;

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.onboarding ,
    navigatorKey: rootNavigatorKey,
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
    redirect: (context, state) {
      final authStatus = ref.read(authProvider);
      // final bool isLoggedIn = ref.read(authProvider.notifier).isLoggedIn();

      if (!showOnboarding && state.fullPath == AppRoutes.onboarding) {
        return authStatus == AuthStatus.authenticated ?
        AppRoutes.home : AppRoutes.login;
      }
      else if (authStatus == AuthStatus.authenticated) {
        // print ('$authStatus');
        return AppRoutes.home;
      }
      else if (authStatus == AuthStatus.unauthenticated &&
          state.fullPath != AppRoutes.login) {
        return AppRoutes.login;
      }
      return null;
    },
  );
}
