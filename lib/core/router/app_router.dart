import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern/core/keys/keys.dart';
import 'package:intern/core/network/local/cache_helper.dart';

import '../../features/auth/provider/auth_notifier.dart';

import 'app_routes.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());

  ref
    ..onDispose(isAuth.dispose)
    ..listen(
      authProvider.select(
        (val) => val.whenData((val) => val),
      ),
      (_, next) {
        isAuth.value = AsyncValue.data(next.value ?? false);
      },
    );

  final router = GoRouter(
    initialLocation: AppRoutes.splash.path,
    navigatorKey: rootNavigatorKey,
    routes: routes,
    refreshListenable: isAuth,
    redirect: (context, state) async {
      final currentPath = state.uri.path;
      final onboardingDone =
          CacheHelper.getData(key: onboardingDoneKey) ?? false;
      final authValue = isAuth.value;
      final loggedIn = authValue.requireValue;

      if (authValue.isLoading || !authValue.hasValue) {
        return AppRoutes.splash.path;
      }

      if (!onboardingDone) {
        return AppRoutes.onboarding.path;
      }

      final allowedUnauthPaths = [
        AppRoutes.splash.path,
        AppRoutes.onboarding.path,
        AppRoutes.login.path,
        AppRoutes.signup.path,
      ];

      if (!loggedIn) {
        if (allowedUnauthPaths.contains(currentPath)) {
          return null;
        }
        return AppRoutes.login.path;
      }
      if (loggedIn && currentPath == AppRoutes.login.path) {
        return AppRoutes.home.path;
      }
      return null;
    },
  );

  ref.onDispose(router.dispose);

  return router;
});
