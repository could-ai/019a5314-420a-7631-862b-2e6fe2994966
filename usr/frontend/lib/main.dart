import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pulsex/src/app_router.dart';
import 'package:pulsex/src/providers/auth_provider.dart';
import 'package:pulsex/src/providers/theme_provider.dart';
import 'package:pulsex/src/services/notification_service.dart';
import 'package:pulsex/src/utils/l10n/app_localizations.dart';
import 'package:pulsex/src/utils/l10n/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('cache');
  await Hive.openBox('bookmarks');
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize Notification Service
  await NotificationService().initialize();
  
  runApp(const ProviderScope(child: PulseXApp()));
}

class PulseXApp extends ConsumerWidget {
  const PulseXApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp.router(
      title: 'PulseX',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('hi', ''),
      ],
      locale: const Locale('en', ''),
    );
  }
}