import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intern/generated/l10n.dart';

import '../core/router/app_routes.dart';
import '../core/util/colors.dart';
import '../core/util/icons.dart';

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
          children: [
            lessonsCard(ref, context),
            const SizedBox(
              height: 5.0,
            ),
            accessoriesCard(ref, context),
          ],
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
          ListTile(
            leading: const Icon(settings),
            title: Text(AppLocalizations.of(context).settings),
            onTap: () {
              context.push(AppRoutes.settings.path);
            },
          ),
        ],
      ),
    );

Widget lessonsCard(WidgetRef ref, BuildContext context) => GestureDetector(
      onTap: () {
        context.push(AppRoutes.lessons.path);
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

Widget accessoriesCard(WidgetRef ref, BuildContext context) => GestureDetector(
      onTap: () {
        context.push(AppRoutes.accessories.path);
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
                  AppLocalizations.of(context).accessories,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
