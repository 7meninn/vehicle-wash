import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/authentication/presentation/pages/splash_screen.dart';
import '../features/authentication/presentation/pages/login_screen.dart';
import '../features/authentication/presentation/pages/otp_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final mobile = state.extra as String? ?? '';
        return OtpScreen(mobileNumber: mobile);
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: const Center(child: Text('Home Screen')),
      ),
    ),
  ],
);
