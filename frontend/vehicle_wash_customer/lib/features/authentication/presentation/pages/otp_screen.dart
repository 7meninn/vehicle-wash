import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import '../providers/auth_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String mobileNumber;
  const OtpScreen({super.key, required this.mobileNumber});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  Future<void> _handleVerify() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the OTP')),
      );
      return;
    }

    final success = await ref.read(authProvider.notifier).verifyOtp(widget.mobileNumber, otp);
    if (success && mounted) {
      context.go('/home'); // Ensure we clear the stack
    } else if (mounted) {
      final error = ref.read(authProvider).error ?? 'Invalid OTP';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: EnterpriseSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: EnterpriseSpacing.sectionPadding / 2),
              Text(
                'Verification',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: EnterpriseSpacing.base),
              Text(
                'Enter the 6-digit code sent to ${widget.mobileNumber}.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: EnterpriseSpacing.sectionPadding),
              EnterpriseCard(
                child: Column(
                  children: [
                    EnterpriseTextField(
                      label: 'OTP Code',
                      hintText: '123456',
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: EnterpriseSpacing.gap * 2),
                    SizedBox(
                      width: double.infinity,
                      child: EnterpriseButton(
                        label: 'Verify & Login',
                        isLoading: authState.isLoading,
                        onPressed: _handleVerify,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
