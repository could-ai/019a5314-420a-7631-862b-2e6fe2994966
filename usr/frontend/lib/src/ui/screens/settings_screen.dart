import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulsex/src/providers/theme_provider.dart';
import 'package:pulsex/src/utils/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.watch(themeProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeNotifier.setTheme(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: const Text('English'),
            onTap: () {
              // TODO: Language selection
            },
          ),
          ListTile(
            title: const Text('Notifications'),
            onTap: () {
              // TODO: Notification settings
            },
          ),
          ListTile(
            title: const Text('Privacy'),
            onTap: () {
              // TODO: Privacy settings
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'PulseX',
                applicationVersion: '1.0.0',
              );
            },
          ),
        ],
      ),
    );
  }
}