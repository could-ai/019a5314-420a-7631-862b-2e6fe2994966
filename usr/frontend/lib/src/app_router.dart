import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulsex/src/providers/auth_provider.dart';
import 'package:pulsex/src/ui/screens/feed_screen.dart';
import 'package:pulsex/src/ui/screens/article_screen.dart';
import 'package:pulsex/src/ui/screens/comments_screen.dart';
import 'package:pulsex/src/ui/screens/profile_screen.dart';
import 'package:pulsex/src/ui/screens/settings_screen.dart';
import 'package:pulsex/src/ui/screens/login_screen.dart';
import 'package:pulsex/src/ui/screens/admin/admin_dashboard_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => authState.isAuthenticated 
          ? const FeedScreen() 
          : const LoginScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/feed',
        builder: (context, state) => const FeedScreen(),
      ),
      GoRoute(
        path: '/article/:id',
        builder: (context, state) {
          final articleId = state.pathParameters['id']!;
          return ArticleScreen(articleId: articleId);
        },
      ),
      GoRoute(
        path: '/comments/:articleId',
        builder: (context, state) {
          final articleId = state.pathParameters['articleId']!;
          return CommentsScreen(articleId: articleId);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = authState.isAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login';
      
      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';
      
      return null;
    },
  );
});