import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:intern/core/keys/keys.dart';
import 'package:intern/core/router/app_routes.dart';

import '../../../core/network/local/cache_helper.dart';
import '../../../core/themes/app_colors.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  Future<void> _completeOnboarding(BuildContext context) async {
    await CacheHelper.saveData(key: onboardingDoneKey, value: true);
    if (context.mounted) {
      context.go(AppRoutes.login.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              OnboardingPage(
                imagePath: Assets.assetsOnboarding1,
                title: AppLocalizations.of(context).welcome,
                description: AppLocalizations.of(context).welcomeSubtitle,
              ),
              OnboardingPage(
                imagePath: Assets.assetsOnboarding2,
                title: AppLocalizations.of(context).secure,
                description: AppLocalizations.of(context).secureSubtitle,
              ),
              OnboardingPage(
                imagePath: Assets.assetsOnboarding3,
                title: AppLocalizations.of(context).fastPerformance,
                description: AppLocalizations.of(context).fastSubtitle,
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                const SizedBox(height: 10),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    activeDotColor: AppColors.defaultBlue2,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _controller.jumpToPage(2);
                      },
                      child: Text(AppLocalizations.of(context).skip),
                    ),
                    onLastPage
                        ? ElevatedButton(
                            onPressed: () {
                              _completeOnboarding(context);
                            },
                            child:
                                Text(AppLocalizations.of(context).getStarted),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(AppLocalizations.of(context).next),
                          ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
