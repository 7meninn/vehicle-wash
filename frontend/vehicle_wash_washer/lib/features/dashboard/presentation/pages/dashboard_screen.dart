import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
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
              _buildAvailabilityToggle(),
              const SizedBox(height: VerdantSpacing.gap * 2),
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

  Widget _buildAvailabilityToggle() {
    return VerdantCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status',
                style: VerdantTypography.labelMedium,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isOnline ? Colors.greenAccent : Colors.redAccent,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isOnline ? 'Online - Ready for jobs' : 'Offline',
                    style: VerdantTypography.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_location_alt_outlined, color: VerdantColors.textPrimary),
                tooltip: 'Service Areas',
                onPressed: () => context.push('/availability/service-areas'),
              ),
              Switch(
                value: _isOnline,
                activeColor: VerdantColors.warmSand,
                onChanged: (val) {
                  setState(() {
                    _isOnline = val;
                  });
                },
              ),
            ],
          ),
        ],
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
                  label: 'View Request',
                  onPressed: () {
                    context.push('/assignment/incoming');
                  },
                ),
              ),
              const SizedBox(width: VerdantSpacing.gap),
              Expanded(
                child: VerdantButton(
                  label: 'Dismiss',
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
