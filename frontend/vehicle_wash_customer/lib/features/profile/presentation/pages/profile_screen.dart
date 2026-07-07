import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import '../providers/profile_provider.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: VerdantColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: VerdantColors.textPrimary),
      ),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator(color: VerdantColors.warmSand)),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error', style: VerdantTypography.bodyLarge),
              const SizedBox(height: VerdantSpacing.gap),
              VerdantButton(
                label: 'Retry',
                onPressed: () => ref.refresh(profileProvider),
              ),
            ],
          ),
        ),
        data: (profile) {
          if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
            _nameController.text = profile.fullName;
            _emailController.text = profile.email ?? '';
          }
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: VerdantSpacing.gap),
                  _buildScoreCard(profile.reliabilityScore),
                  const SizedBox(height: VerdantSpacing.sectionPadding),
                  
                  Text('Mobile Number', style: VerdantTypography.labelLarge),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: VerdantColors.surfaceElevated,
                      borderRadius: VerdantRadius.smallRadius,
                      border: Border.all(color: VerdantColors.border),
                    ),
                    child: Text(profile.mobileNumber, style: VerdantTypography.bodyLarge),
                  ),
                  const SizedBox(height: VerdantSpacing.gap),
                  
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: VerdantSpacing.gap),
                  
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email Address (Optional)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: VerdantSpacing.sectionPadding),
                  
                  VerdantButton(
                    label: 'Save Changes',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await ref.read(profileProvider.notifier).updateProfile(
                            _nameController.text.trim(),
                            _emailController.text.trim(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile updated successfully!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to update profile: $e')),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: VerdantSpacing.gap),
                  VerdantButton(
                    label: 'Logout',
                    variant: VerdantButtonVariant.secondary,
                    onPressed: () {
                      // TODO: Implement logout logic when available
                      context.go('/login');
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScoreCard(int score) {
    return Container(
      padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
      decoration: BoxDecoration(
        color: VerdantColors.warmSand.withOpacity(0.1),
        borderRadius: VerdantRadius.largeRadius,
        border: Border.all(color: VerdantColors.warmSand),
      ),
      child: Column(
        children: [
          Text('Reliability Score', style: VerdantTypography.titleMedium),
          const SizedBox(height: 8),
          Text(
            score.toString(),
            style: VerdantTypography.displaySmall.copyWith(
              color: VerdantColors.warmSand,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
