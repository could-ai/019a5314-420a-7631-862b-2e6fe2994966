import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class AuthState {
  final bool isAuthenticated;
  final String? userId;
  final String? name;
  final String? email;
  final List<String> roles;
  final String? accessToken;
  final String? refreshToken;
  
  const AuthState({
    this.isAuthenticated = false,
    this.userId,
    this.name,
    this.email,
    this.roles = const [],
    this.accessToken,
    this.refreshToken,
  });
  
  AuthState copyWith({
    bool? isAuthenticated,
    String? userId,
    String? name,
    String? email,
    List<String>? roles,
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final Dio _dio;
  
  AuthService(this._dio);
  
  Future<AuthState> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return const AuthState();
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String idToken = googleAuth.idToken!;
      
      // Exchange with backend
      final response = await _dio.post('/api/v1/auth/google/', data: {
        'id_token': idToken,
      });
      
      final data = response.data;
      final authState = AuthState(
        isAuthenticated: true,
        userId: data['user']['id'],
        name: data['user']['name'],
        email: data['user']['email'],
        roles: List<String>.from(data['user']['roles'] ?? []),
        accessToken: data['access'],
        refreshToken: data['refresh'],
      );
      
      // Store tokens securely
      await _secureStorage.write(key: 'access_token', value: authState.accessToken);
      await _secureStorage.write(key: 'refresh_token', value: authState.refreshToken);
      
      return authState;
    } catch (e) {
      debugPrint('Google sign in error: $e');
      return const AuthState();
    }
  }
  
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
  }
  
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }
  
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final dio = ref.watch(apiServiceProvider);
  return AuthNotifier(AuthService(dio));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  
  AuthNotifier(this._authService) : super(const AuthState()) {
    _loadStoredAuth();
  }
  
  Future<void> _loadStoredAuth() async {
    final accessToken = await _authService.getAccessToken();
    if (accessToken != null) {
      // TODO: Validate token and load user info
      state = state.copyWith(isAuthenticated: true);
    }
  }
  
  Future<void> signIn() async {
    final newState = await _authService.signInWithGoogle();
    state = newState;
  }
  
  Future<void> signOut() async {
    await _authService.signOut();
    state = const AuthState();
  }
}