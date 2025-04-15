import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intern/core/localization_notifier.dart';
import 'package:intern/generated/l10n.dart';

import '../core/router/app_routes.dart';
import '../core/theme_notifier.dart';
import '../core/util/colors.dart';
import '../core/util/icons.dart';

import 'auth/provider/auth_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
      ),
      drawer: drawer(ref, context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [lessonsCard(ref, context)],
        ),
      ),
    );
  }
}

Widget drawer(WidgetRef ref, BuildContext context) => Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 95,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: defaultBlue2),
              child: Text(
                AppLocalizations.of(context).menu,
                style: const TextStyle(color: white, fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            padding: const EdgeInsets.all(10.0),
            value: ref.watch(languageProvider).languageCode,
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'ar', child: Text('العربية')),
            ],
            onChanged: (value) {
              if (value != null) {
                ref.read(languageProvider.notifier).setLocale(value);
              }
            },
            underline: const SizedBox(),
            menuWidth : MediaQuery.of(context).size.width * 0.7
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Icon(
              ref.watch(themeProvider) == ThemeMode.dark
                  ? darkMode
                  : darkModeOutlined,
            ),
            title: Text(AppLocalizations.of(context).darkMode),
            onTap: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(delete),
            title: Text(AppLocalizations.of(context).clearCache),
            onTap: () {
              ref.read(authProvider.notifier).clearCache();
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(logout),
            title: Text(AppLocalizations.of(context).logout),
            onTap: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
    );

Widget lessonsCard(WidgetRef ref, BuildContext context) => GestureDetector(
      onTap: () {
        context.push(AppRoutes.lessons);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  AppLocalizations.of(context).onlineLessons,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
