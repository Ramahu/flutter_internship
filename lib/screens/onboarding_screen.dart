import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../navigator.dart';
import 'home_screen.dart';
import 'widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

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
                imagePath: 'assets/onboarding1.png',
                title: 'Welcome',
                description: 'Experience our app with a clean and fast UI.',
              ),
              OnboardingPage(
                imagePath:  'assets/onboarding2.png',
                title: 'Secure',
                description: 'Your data is safe with us at all times.',
              ),
              OnboardingPage(
                imagePath:  'assets/onboarding3.png',
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
                        navigateAndReplace( context,const HomeScreen());
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


