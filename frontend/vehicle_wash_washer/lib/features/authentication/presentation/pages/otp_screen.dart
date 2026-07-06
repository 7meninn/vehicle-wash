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
      context.go('/onboarding');
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
          padding: const EdgeInsets.symmetric(horizontal: VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: VerdantSpacing.sectionPadding / 2),
              Text(
                'Verification',
                style: VerdantTypography.displayMedium,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Enter the 6-digit code sent to ${widget.mobileNumber}.',
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding),
              VerdantCard(
                child: Column(
                  children: [
                    VerdantTextField(
                      label: 'OTP Code',
                      hintText: '123456',
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: VerdantSpacing.gap * 2),
                    SizedBox(
                      width: double.infinity,
                      child: VerdantButton(
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
