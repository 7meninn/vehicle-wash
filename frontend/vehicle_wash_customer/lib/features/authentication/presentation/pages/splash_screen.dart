import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Add artificial delay for splash screen aesthetics
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      await ref.read(authProvider.notifier).checkAuthStatus();
      if (!mounted) return;
      
      final authState = ref.read(authProvider);
      if (authState.isAuthenticated) {
        context.go('/home'); // Assuming home route exists or will be created
      } else {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verdant\nWash',
              textAlign: TextAlign.center,
              style: VerdantTypography.displayMedium,
            ),
            const SizedBox(height: VerdantSpacing.sectionPadding),
            const VerdantLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
