import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intern/core/network/local/cache_helper.dart';
import 'package:intern/core/util/storage_keys.dart';

import '../../features/accessory/page/accessory_screen.dart';
import '../../features/accessory/page/audio_player_screen.dart';
import '../../features/accessory/page/image_viewer_screen.dart';
import '../../features/accessory/page/model_viewer_screen.dart';
import '../../features/accessory/page/pdf_viewer_screen.dart';
import '../../features/accessory/page/video_player_screen.dart';
import '../../features/accessory/page/youtube_player_screen.dart';
import '../../features/auth/page/login_screen.dart';
import '../../features/auth/page/signup_screen.dart';
import '../../features/auth/provider/auth_notifier.dart';
import '../../features/home_screen.dart';
import '../../features/lessons/page/lesson_screen.dart';
import '../../features/onboarding/page/onboarding_screen.dart';
import '../../features/settings/page/settings_screen.dart';
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
    initialLocation: AppRoutes.splash.path,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding.path,
        name: AppRoutes.onboarding.name,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup.path,
        name: AppRoutes.signup.name,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.lessons.path,
        name: AppRoutes.lessons.name,
        builder: (context, state) => const LessonScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings.path,
        name: AppRoutes.settings.name,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.accessories.path,
        name: AppRoutes.accessories.name,
        builder: (context, state) => const AccessoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.imageViewer.path,
        name: AppRoutes.imageViewer.name,
        builder: (context, state) {
          final imageUrl = state.uri.queryParameters['url']!;
          return ImageViewerScreen(imageUrl: imageUrl);
        },
      ),
      GoRoute(
        path: AppRoutes.audioPlayer.path,
        name: AppRoutes.audioPlayer.name,
        builder: (context, state) {
          final audioUrl = state.uri.queryParameters['url']!;
          return AudioPlayerScreen(url: audioUrl);
        },
      ),
      GoRoute(
        path: AppRoutes.youtubePlayer.path,
        name: AppRoutes.youtubePlayer.name,
        builder: (context, state) {
          final videoId = state.uri.queryParameters['url']!;
          return YoutubePlayerScreen(videoId: videoId);
        },
      ),
      GoRoute(
        path: AppRoutes.videoPlayer.path,
        name: AppRoutes.videoPlayer.name,
        builder: (context, state) {
          final videoUrl = state.uri.queryParameters['url']!;
          return VideoPlayerScreen(videoUrl: videoUrl);
        },
      ),
      GoRoute(
        path: AppRoutes.pdfViewer.path,
        name: AppRoutes.pdfViewer.name,
        builder: (context, state) {
          final pdfUrl = state.uri.queryParameters['url']!;
          return PdfViewerScreen(pdfUrl: pdfUrl);
        },
      ),
      GoRoute(
        path: AppRoutes.modelViewer.path,
        name: AppRoutes.modelViewer.name,
        builder: (context, state) {
          final modelUrl = state.uri.queryParameters['url']!;
          return ModelViewerScreen(modelUrl: modelUrl);
        },
      ),
    ],
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
