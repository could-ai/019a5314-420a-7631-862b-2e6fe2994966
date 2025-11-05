import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pulsex/src/providers/auth_provider.dart';
import 'package:pulsex/src/services/auth_service.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authNotifier.signIn();
            if (context.mounted && ref.read(authProvider).isAuthenticated) {
              context.go('/');
            }
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}