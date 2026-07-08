import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
    if (mounted) {
      await ref.read(authProvider.notifier).checkAuthStatus();
      if (!mounted) return;
      
      final authState = ref.read(authProvider);
      if (authState.isAuthenticated) {
        context.go('/dashboard'); 
      } else {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VerdantColors.surfacePrimary,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              VerdantColors.primary.withOpacity(0.05),
              VerdantColors.surfacePrimary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_car_wash_rounded,
                size: 80,
                color: VerdantColors.primary,
              ).animate()
               .scale(duration: 600.ms, curve: Curves.easeOutBack)
               .fadeIn(duration: 400.ms)
               .then(delay: 200.ms)
               .shimmer(duration: 1000.ms, color: Colors.white70),
              
              const SizedBox(height: VerdantSpacing.gap * 2),
              
              Text(
                'VERDANT\nWASH',
                textAlign: TextAlign.center,
                style: VerdantTypography.displayMedium.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  height: 1.1,
                ),
              ).animate()
               .fadeIn(delay: 400.ms, duration: 600.ms)
               .slideY(begin: 0.2, curve: Curves.easeOutQuint),
               
              const SizedBox(height: 8),
              
              Text(
                'Washer Portal',
                style: VerdantTypography.titleLarge.copyWith(
                  color: VerdantColors.textSecondary,
                  letterSpacing: 2,
                ),
              ).animate()
               .fadeIn(delay: 800.ms, duration: 600.ms),
              
              const SizedBox(height: 60),
              
              const VerdantLoadingIndicator()
                .animate()
                .fadeIn(delay: 1200.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
