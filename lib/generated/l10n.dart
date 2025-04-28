// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Menu`
  String get menu {
    return Intl.message('Menu', name: 'menu', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Clear cache`
  String get clearCache {
    return Intl.message('Clear cache', name: 'clearCache', desc: '', args: []);
  }

  /// `Search here`
  String get searchHere {
    return Intl.message('Search here', name: 'searchHere', desc: '', args: []);
  }

  /// `Online Lessons`
  String get onlineLessons {
    return Intl.message(
      'Online Lessons',
      name: 'onlineLessons',
      desc: '',
      args: [],
    );
  }

  /// `Select subject`
  String get selectSubject {
    return Intl.message(
      'Select subject',
      name: 'selectSubject',
      desc: '',
      args: [],
    );
  }

  /// `No more lessons.`
  String get noMoreLessons {
    return Intl.message(
      'No more lessons.',
      name: 'noMoreLessons',
      desc: '',
      args: [],
    );
  }

  /// `No lessons available.`
  String get noLessonsAvailable {
    return Intl.message(
      'No lessons available.',
      name: 'noLessonsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Please enter email address`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please enter email address',
      name: 'pleaseEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Need an account ?`
  String get needAccount {
    return Intl.message(
      'Need an account ?',
      name: 'needAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Experience our app with a clean and fast UI.`
  String get welcomeSubtitle {
    return Intl.message(
      'Experience our app with a clean and fast UI.',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Secure`
  String get secure {
    return Intl.message('Secure', name: 'secure', desc: '', args: []);
  }

  /// `Your data is safe with us at all times.`
  String get secureSubtitle {
    return Intl.message(
      'Your data is safe with us at all times.',
      name: 'secureSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Fast Performance`
  String get fastPerformance {
    return Intl.message(
      'Fast Performance',
      name: 'fastPerformance',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy blazing fast speed across all platforms.`
  String get fastSubtitle {
    return Intl.message(
      'Enjoy blazing fast speed across all platforms.',
      name: 'fastSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Accessories`
  String get accessories {
    return Intl.message('Accessories', name: 'accessories', desc: '', args: []);
  }

  /// `No more Accessories`
  String get noAccessoryMore {
    return Intl.message(
      'No more Accessories',
      name: 'noAccessoryMore',
      desc: '',
      args: [],
    );
  }

  /// `No Accessories available`
  String get noAccessoryAvailable {
    return Intl.message(
      'No Accessories available',
      name: 'noAccessoryAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Select Type`
  String get selectType {
    return Intl.message('Select Type', name: 'selectType', desc: '', args: []);
  }

  /// `Image`
  String get image {
    return Intl.message('Image', name: 'image', desc: '', args: []);
  }

  /// `View Image`
  String get viewImage {
    return Intl.message('View Image', name: 'viewImage', desc: '', args: []);
  }

  /// `Watch Video`
  String get watchVideo {
    return Intl.message('Watch Video', name: 'watchVideo', desc: '', args: []);
  }

  /// `Open PDF`
  String get openPDF {
    return Intl.message('Open PDF', name: 'openPDF', desc: '', args: []);
  }

  /// `Play Audio`
  String get playAudio {
    return Intl.message('Play Audio', name: 'playAudio', desc: '', args: []);
  }

  /// `Audio Player`
  String get audioPlayer {
    return Intl.message(
      'Audio Player',
      name: 'audioPlayer',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get speed {
    return Intl.message('Speed', name: 'speed', desc: '', args: []);
  }

  /// `Volume`
  String get Volume {
    return Intl.message('Volume', name: 'Volume', desc: '', args: []);
  }

  /// `Video Player`
  String get videoPlayer {
    return Intl.message(
      'Video Player',
      name: 'videoPlayer',
      desc: '',
      args: [],
    );
  }

  /// `PDF Viewer`
  String get pdfViewer {
    return Intl.message('PDF Viewer', name: 'pdfViewer', desc: '', args: []);
  }

  /// `3D Model Viewer`
  String get modelViewer {
    return Intl.message(
      '3D Model Viewer',
      name: 'modelViewer',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
