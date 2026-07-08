import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();

  Future<void> _handleLogin() async {
    final mobile = _mobileController.text.trim();
    if (mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a mobile number')),
      );
      return;
    }

    final success = await ref.read(authProvider.notifier).requestOtp(mobile);
    if (success && mounted) {
      context.push('/otp', extra: mobile);
    } else if (mounted) {
      final error = ref.read(authProvider).error ?? 'An error occurred';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(
                Icons.local_car_wash_rounded,
                size: 64,
                color: VerdantColors.primary,
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2),
              const SizedBox(height: VerdantSpacing.gap * 2),
              Text(
                'Welcome Back',
                style: VerdantTypography.displayMedium.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Enter your mobile number to access your washer portal.',
                style: VerdantTypography.bodyLarge.copyWith(color: VerdantColors.textSecondary),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
              const SizedBox(height: VerdantSpacing.sectionPadding),
              VerdantCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    VerdantTextField(
                      label: 'Mobile Number',
                      hintText: '+1 234 567 8900',
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: VerdantSpacing.gap * 2),
                    SizedBox(
                      width: double.infinity,
                      child: VerdantButton(
                        label: 'Continue',
                        isLoading: authState.isLoading,
                        onPressed: _handleLogin,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms, duration: 500.ms).slideY(begin: 0.1),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
