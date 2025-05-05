import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/util/icons.dart';
import '../../../generated/l10n.dart';
import '../../auth/provider/auth_notifier.dart';
import '../provider/locale_provider.dart';
import '../provider/theme_notifier.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Dropdown
          cardWidget(
            DropdownButton<String>(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              value: ref.watch(localeProvider).languageCode,
              underline: const SizedBox(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(localeProvider.notifier).setLocale(value);
                }
              },
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ar', child: Text('العربية')),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Dark Theme Toggle
          cardWidget(
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
          ),
          const SizedBox(height: 10),
          // Clear Cache Button
          cardWidget(
            ListTile(
              leading: const Icon(delete),
              title: Text(AppLocalizations.of(context).clearCache),
              onTap: authNotifier.clearCache,
            ),
          ),
          const SizedBox(height: 10),
          // Logout Button
          cardWidget(
            ListTile(
              leading: const Icon(logout),
              title: Text(AppLocalizations.of(context).logout),
              onTap: authNotifier.logout,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

Widget cardWidget(Widget child) => Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: child,
      ),
    );
