import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intern/core/keys/keys.dart';
import 'package:intern/core/network/local/cache_helper.dart';

import '../../features/auth/provider/auth_notifier.dart';

import 'app_routes.dart';
import 'routes.dart';


final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
final onboardingDone = CacheHelper.getData(key: onboardingDoneKey) ?? false;

final routerProvider = Provider<GoRouter>((ref) {
  ref.onDispose(isAuth.dispose);

  ref.listen<AsyncValue<bool>>(
    authProvider,
    (_, next) => isAuth.value = next,
  );

  return GoRouter(
    initialLocation: AppRoutes.splash.path,
    navigatorKey: rootNavigatorKey,
    routes: routes,
    refreshListenable: isAuth,
    redirect: (context, state) async {
      final authValue = isAuth.value;
      if (authValue.isLoading) return null;

      final loggedIn = authValue.value ?? false;

      if (state.fullPath == AppRoutes.splash.path) return null;
      if (onboardingDone &&
          !loggedIn &&
          state.fullPath != AppRoutes.login.path) {
        return AppRoutes.login.path;
      }
      if (loggedIn && state.fullPath == AppRoutes.login.path) {
        return AppRoutes.home.path;
      }
      return null;
    },
  );
});
