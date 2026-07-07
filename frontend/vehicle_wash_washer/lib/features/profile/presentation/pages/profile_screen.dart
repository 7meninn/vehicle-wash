import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import '../providers/profile_provider.dart';
import '../../domain/entities/washer_profile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsyncValue = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: profileAsyncValue.when(
        data: (profile) => _buildProfileContent(context, profile),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, WasherProfile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: VerdantSpacing.gap * 2),
          Text(
            profile.fullName,
            style: VerdantTypography.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            profile.mobileNumber,
            style: VerdantTypography.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: VerdantSpacing.gap * 2),
          VerdantCard(
            padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Verification Status', profile.verificationStatus),
                const Divider(),
                _buildInfoRow('Average Rating', profile.averageRating.toStringAsFixed(2)),
                const Divider(),
                _buildInfoRow('Trust Score', '${profile.trustScore.toStringAsFixed(1)}%'),
                const Divider(),
                _buildInfoRow('Completed Jobs', profile.totalCompletedJobs.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: VerdantSpacing.gap),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: VerdantTypography.bodyLarge),
          Text(value, style: VerdantTypography.titleMedium),
        ],
      ),
    );
  }
}
