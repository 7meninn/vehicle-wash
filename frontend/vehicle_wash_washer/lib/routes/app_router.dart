import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/authentication/presentation/pages/splash_screen.dart';
import '../features/authentication/presentation/pages/login_screen.dart';
import '../features/authentication/presentation/pages/otp_screen.dart';
import '../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../features/availability/presentation/pages/service_areas_screen.dart';
import '../features/assignment/presentation/pages/incoming_request_screen.dart';
import '../features/job/presentation/pages/current_job_screen.dart';
import '../features/job/presentation/pages/media_upload_screen.dart';
import '../features/job/presentation/pages/job_summary_screen.dart';

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
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/availability/service-areas',
      builder: (context, state) => const ServiceAreasScreen(),
    ),
    GoRoute(
      path: '/assignment/incoming',
      builder: (context, state) => const IncomingRequestScreen(),
    ),
    GoRoute(
      path: '/job/current',
      builder: (context, state) => const CurrentJobScreen(),
    ),
    GoRoute(
      path: '/job/media-upload',
      builder: (context, state) => const MediaUploadScreen(),
    ),
    GoRoute(
      path: '/job/summary',
      builder: (context, state) => const JobSummaryScreen(),
    ),
  ],
);
