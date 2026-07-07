import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import '../providers/earnings_provider.dart';

class EarningsScreen extends ConsumerStatefulWidget {
  const EarningsScreen({super.key});

  @override
  ConsumerState<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends ConsumerState<EarningsScreen> {
  String get _weekStart {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: now.weekday - 1));
    return "${start.year}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}";
  }

  String get _weekEnd {
    final now = DateTime.now();
    final end = now.add(Duration(days: 7 - now.weekday));
    return "${end.year}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings & Payouts'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCurrentWeekEarnings(),
            const SizedBox(height: VerdantSpacing.gap * 2),
            Text(
              'Payout History',
              style: VerdantTypography.headlineMedium,
            ),
            const SizedBox(height: VerdantSpacing.base),
            _buildPayoutHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeekEarnings() {
    final earningsAsync = ref.watch(weeklyEarningsProvider({
      'weekStart': _weekStart,
      'weekEnd': _weekEnd,
    }));

    return earningsAsync.when(
      data: (earning) => VerdantCard(
        padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
        child: Column(
          children: [
            Text('THIS WEEK', style: VerdantTypography.labelMedium),
            const SizedBox(height: VerdantSpacing.base),
            Text('\$${earning.estimatedPayout.toStringAsFixed(2)}',
                style: VerdantTypography.displayMedium.copyWith(color: VerdantColors.warmSand)),
            const SizedBox(height: VerdantSpacing.base),
            Text('${earning.completedJobs} Jobs Completed', style: VerdantTypography.bodyLarge),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load earnings: $e'),
    );
  }

  Widget _buildPayoutHistory() {
    final payoutsAsync = ref.watch(payoutHistoryProvider);

    return payoutsAsync.when(
      data: (payouts) {
        if (payouts.isEmpty) {
          return const Center(child: Text('No payouts yet.'));
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: payouts.length,
          separatorBuilder: (context, index) => const SizedBox(height: VerdantSpacing.gap),
          itemBuilder: (context, index) {
            final payout = payouts[index];
            return VerdantCard(
              padding: const EdgeInsets.all(VerdantSpacing.base),
              child: ListTile(
                title: Text(payout.week, style: VerdantTypography.titleMedium),
                subtitle: Text('Status: ${payout.status}', style: VerdantTypography.bodyMedium),
                trailing: Text('\$${payout.amount.toStringAsFixed(2)}',
                    style: VerdantTypography.titleLarge.copyWith(color: VerdantColors.textPrimary)),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load payouts: $e'),
    );
  }
}
