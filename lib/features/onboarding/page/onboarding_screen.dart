import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:intern/core/router/app_routes.dart';
import 'package:intern/core/util/storage_keys.dart';

import '../../../core/network/local/cache_helper.dart';
import '../../../generated/assets.dart';
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
      context.go(AppRoutes.login);
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
            children: const [
              OnboardingPage(
                imagePath: Assets.assetsOnboarding1,
                title: 'Welcome',
                description: 'Experience our app with a clean and fast UI.',
              ),
              OnboardingPage(
                imagePath: Assets.assetsOnboarding2,
                title: 'Secure',
                description: 'Your data is safe with us at all times.',
              ),
              OnboardingPage(
                imagePath: Assets.assetsOnboarding3,
                title: 'Fast Performance',
                description: 'Enjoy blazing fast speed across all platforms.',
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    activeDotColor: Theme.of(context).colorScheme.primary,
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
                      child: const Text('Skip'),
                    ),
                    onLastPage
                        ? ElevatedButton(
                            onPressed: () {
                              _completeOnboarding(context);
                            },
                            child: const Text('Get Started'),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Text('Next'),
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
