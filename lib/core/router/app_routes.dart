class AppRoute {
  const AppRoute({required this.name, required this.path});
  final String name;
  final String path;
}

class AppRoutes {
  static const splash = AppRoute(name: 'splash', path: '/splash');
  static const onboarding = AppRoute(name: 'onboarding', path: '/onboarding');
  static const login = AppRoute(name: 'login', path: '/login');
  static const signup = AppRoute(name: 'signup', path: '/signup');
  static const home = AppRoute(name: 'home', path: '/home');
  static const lessons = AppRoute(name: 'lessons', path: '/lessons');
  static const settings = AppRoute(name: 'settings', path: '/settings');
  static const accessories =
      AppRoute(name: 'accessories', path: '/accessories');

  static const imageViewer =
      AppRoute(name: 'imageViewer', path: '/image_viewer');
  static const audioPlayer =
      AppRoute(name: 'audioPlayer', path: '/audioPlayer');
  static const videoPlayer =
      AppRoute(name: 'videoPlayer', path: '/videoPlayer');
  static const youtubePlayer =
      AppRoute(name: 'YoutubePlayer', path: '/YoutubePlayer');
  static const pdfViewer = AppRoute(name: 'pdfViewer', path: '/pdfViewer');
  static const modelViewer =
      AppRoute(name: 'modelViewer', path: '/modelViewer');
}
