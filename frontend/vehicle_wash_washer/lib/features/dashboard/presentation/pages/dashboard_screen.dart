import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildEarningsSummary(),
              const SizedBox(height: VerdantSpacing.gap * 2),
              _buildSectionHeader('Today\'s Jobs'),
              const SizedBox(height: VerdantSpacing.base),
              _buildJobCard('Premium Wash', '10:00 AM', '123 Main St, Springfield'),
              const SizedBox(height: VerdantSpacing.base),
              _buildJobCard('Standard Wash', '01:00 PM', '456 Elm St, Springfield'),
              
              const SizedBox(height: VerdantSpacing.gap * 2),
              _buildSectionHeader('Booking Requests'),
              const SizedBox(height: VerdantSpacing.base),
              _buildRequestCard('Deep Clean', 'Tomorrow, 09:00 AM', '789 Oak St, Springfield'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsSummary() {
    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TODAY\'s EARNINGS',
            style: VerdantTypography.labelMedium,
          ),
          const SizedBox(height: VerdantSpacing.base),
          Text(
            '\$124.50',
            style: VerdantTypography.displayMedium.copyWith(
              color: VerdantColors.warmSand,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: VerdantTypography.headlineMedium,
    );
  }

  Widget _buildJobCard(String service, String time, String address) {
    return VerdantCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service, style: VerdantTypography.titleLarge),
                const SizedBox(height: 4),
                Text('$time • $address', style: VerdantTypography.bodyMedium),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: VerdantColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildRequestCard(String service, String time, String address) {
    return VerdantCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(service, style: VerdantTypography.titleLarge),
          const SizedBox(height: 4),
          Text('$time • $address', style: VerdantTypography.bodyMedium),
          const SizedBox(height: VerdantSpacing.gap),
          Row(
            children: [
              Expanded(
                child: VerdantButton(
                  label: 'Accept',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: VerdantSpacing.gap),
              Expanded(
                child: VerdantButton(
                  label: 'Decline',
                  variant: VerdantButtonVariant.secondary,
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
