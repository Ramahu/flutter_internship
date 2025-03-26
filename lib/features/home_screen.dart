import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/router/app_routes.dart';
import '../core/util/colors.dart';
import '../core/util/icons.dart';
import 'auth/provider/auth_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: drawer(ref,context),
      body: const Center(
        child: Text('HOME'),
      ),
    );
  }
}

Widget drawer(WidgetRef ref,BuildContext context) => Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const SizedBox(
        height: 80,
        child: DrawerHeader(
          decoration: BoxDecoration(color: defaultBlue2),
          child: Text('Menu',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
      const SizedBox(height: 10),
      ListTile(
        leading: const Icon(logout),
        title: const Text('Logout'),
        onTap: () {
          ref.read(authProvider.notifier).logout();
          context.go(AppRoutes.login);
          },
      ),
    ],
  ),
);
