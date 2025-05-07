import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/keys/keys.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/services/local_storage/secure_storage.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/constants/assets.dart';
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
    final secureStorage = SecureStorage();
    final token = await secureStorage.getData(key: tokenKey);

    final isLoggedIn = token != null && token.isNotEmpty;

    await ref.read(authNotifierProvider.notifier).setLoggedIn(isLoggedIn);

    if (!mounted) return;
    if (isLoggedIn) {
      context.go(AppRoutes.home.path);
    } else {
      context.go(AppRoutes.login.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image(
          height: 160,
          image: AssetImage(Assets.assetsLogo),
        ),
      ),
    );
  }
}
