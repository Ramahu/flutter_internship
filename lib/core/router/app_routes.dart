enum AppRoutes {
  splash('/', 'splash'),
  onboarding('/onboarding', 'onboarding'),
  signup('/signup', 'signup'),
  login('/login', 'login'),
  home('/home', 'home'),
  lessons('/lessons', 'lessons'),
  settings('/settings', 'settings'),
  accessories('/accessories', 'accessories'),
  imageViewer('/imageViewer', 'imageViewer'),
  audioPlayer('/audioPlayer', 'audioPlayer'),
  videoPlayer('/videoPlayer', 'videoPlayer'),
  youtubePlayer('/youtubePlayer', 'youtubePlayer'),
  pdfViewer('/pdfViewer', 'pdfViewer'),
  modelViewer('/modelViewer', 'modelViewer');

  final String path;
  final String name;
  // ignore: sort_constructors_first
  const AppRoutes(this.path, this.name);
}
