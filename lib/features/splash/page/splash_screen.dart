import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/local/cache_helper.dart';
import '../../../core/network/local/secure_storage.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/util/colors.dart';
import '../../../core/util/storage_keys.dart';
import '../../../generated/assets.dart';
import '../../auth/provider/auth_notifier.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final onboardingDone = CacheHelper.getData(key: onboardingDoneKey) ?? false;
    final secureStorage = SecureStorage();
    final token = await secureStorage.getData(key: tokenKey);

    final isLoggedIn = token != null && token.isNotEmpty;

    await ref.read(authProvider.notifier).setLoggedIn(isLoggedIn);

    if (!mounted) return;
    if (!onboardingDone) {
      context.go(AppRoutes.onboarding);
    } else if (isLoggedIn) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor : white,
      body: Center(
        child: Image(
          height: 160,
          image: AssetImage(Assets.assetsLogo),
        ),
      ),
    );
  }
}
