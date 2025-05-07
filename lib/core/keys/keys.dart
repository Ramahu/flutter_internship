import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

const String localeKey = 'locale';
const String tokenKey = 'auth_token';
const String darkModeKey = 'isDarkMode';
const String onboardingDoneKey = 'onboarding_done';
