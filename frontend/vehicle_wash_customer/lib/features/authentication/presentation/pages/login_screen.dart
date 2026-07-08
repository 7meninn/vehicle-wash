import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: EnterpriseSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: EnterpriseSpacing.base),
              Text(
                'Enter your mobile number to continue.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: EnterpriseSpacing.sectionPadding),
              EnterpriseCard(
                child: Column(
                  children: [
                    EnterpriseTextField(
                      label: 'Mobile Number',
                      hintText: '+1 234 567 8900',
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: EnterpriseSpacing.gap * 2),
                    SizedBox(
                      width: double.infinity,
                      child: EnterpriseButton(
                        label: 'Continue',
                        isLoading: authState.isLoading,
                        onPressed: _handleLogin,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
