import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intern/core/network/local/cache_helper.dart';
import 'package:intern/core/util/storage_keys.dart';

import '../../features/auth/page/login_screen.dart';
import '../../features/auth/page/signup_screen.dart';
import '../../features/auth/provider/auth_notifier.dart';
import '../../features/home_screen.dart';
import '../../features/lessons/page/lesson_screen.dart';
import '../../features/onboarding/page/onboarding_screen.dart';
import '../../features/splash/page/splash_screen.dart';

import 'app_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
final onboardingDone = CacheHelper.getData(key: onboardingDoneKey) ?? false;

final routerProvider = Provider<GoRouter>((ref) {
  ref.onDispose(isAuth.dispose);

  ref.listen<AsyncValue<bool>>(
    authProvider,
    (_, next) => isAuth.value = next,
  );

  return GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.lessons,
        builder: (context, state) => const LessonScreen(),
      ),
    ],
    refreshListenable: isAuth,
    redirect: (context, state) async {
      final authValue = isAuth.value;
      if (authValue.isLoading) return null;

      final loggedIn = authValue.value ?? false;

      if (state.fullPath == AppRoutes.splash) return null;
      if (onboardingDone && !loggedIn && state.fullPath != AppRoutes.login) {
        return AppRoutes.login;
      }
      if (loggedIn && state.fullPath == AppRoutes.login) {
        return AppRoutes.home;
      }
      return null;
    },
  );
});
