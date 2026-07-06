import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String? _kycFilePath;

  void _mockFilePick() {
    setState(() {
      _kycFilePath = '/storage/emulated/0/Download/dummy_kyc_document.pdf';
    });
  }

  void _handleSubmit() {
    if (_nameController.text.isEmpty || _mobileController.text.isEmpty || _kycFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all details and upload KYC')),
      );
      return;
    }
    // Mock successful submission
    context.go('/dashboard');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Washer Onboarding'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Complete Your Profile',
                style: VerdantTypography.headlineLarge,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'We need a few details to verify your account.',
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding / 2),
              VerdantCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerdantTextField(
                      label: 'Full Name',
                      hintText: 'John Doe',
                      controller: _nameController,
                    ),
                    const SizedBox(height: VerdantSpacing.gap),
                    VerdantTextField(
                      label: 'Mobile Number',
                      hintText: '+1 234 567 8900',
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: VerdantSpacing.gap * 2),
                    Text(
                      'KYC DOCUMENT',
                      style: VerdantTypography.labelMedium,
                    ),
                    const SizedBox(height: VerdantSpacing.base),
                    if (_kycFilePath != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: VerdantColors.surfaceElevated,
                          borderRadius: VerdantRadius.smallRadius,
                          border: Border.all(color: VerdantColors.border),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.description, color: VerdantColors.warmSand),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _kycFilePath!.split('/').last,
                                style: VerdantTypography.bodyLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () => setState(() => _kycFilePath = null),
                            ),
                          ],
                        ),
                      )
                    else
                      VerdantButton(
                        label: 'Upload Document',
                        variant: VerdantButtonVariant.secondary,
                        icon: Icons.upload_file,
                        onPressed: _mockFilePick,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding),
              VerdantButton(
                label: 'Submit Application',
                onPressed: _handleSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
