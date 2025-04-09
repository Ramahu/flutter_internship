import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
        title: const Text('Home'),
        elevation: 2,
      ),
      drawer: drawer(ref, context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [lessonsCard(ref, context), subjectCard(ref, context)],
        ),
      ),
    );
  }
}

Widget drawer(WidgetRef ref, BuildContext context) => Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 95,
            child: DrawerHeader(
              decoration: BoxDecoration(color: defaultBlue2),
              child: Text(
                'Menu',
                style: TextStyle(color: white, fontSize: 24),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Icon(
              ref.watch(themeProvider) == ThemeMode.dark
                  ? darkMode
                  : darkModeOutlined,
            ),
            title: const Text('Dark Mode'),
            onTap: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(logout),
            title: const Text('Logout'),
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
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(book, size: 40),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Online Lessons',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget subjectCard(WidgetRef ref, BuildContext context) => GestureDetector(
      onTap: () {
        context.push(AppRoutes.subjectFilter);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(book, size: 40),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Subject',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
