import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class JobSummaryScreen extends StatelessWidget {
  const JobSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: VerdantColors.whiteTransparent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.task_alt,
                    size: 80,
                    color: VerdantColors.warmSand,
                  ),
                ),
              ),
              const SizedBox(height: VerdantSpacing.gap * 2),
              
              Text(
                'Job Completed',
                textAlign: TextAlign.center,
                style: VerdantTypography.displaySmall,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Excellent work. The customer has been notified.',
                textAlign: TextAlign.center,
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding),
              
              VerdantCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text('EARNED PAYOUT', style: VerdantTypography.labelMedium),
                    const SizedBox(height: VerdantSpacing.gap),
                    Text(
                      '\$42.00',
                      style: VerdantTypography.displayMedium.copyWith(color: VerdantColors.warmSand),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: VerdantSpacing.gap),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Service', style: VerdantTypography.bodyMedium),
                        Text('Premium Wash', style: VerdantTypography.titleMedium),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Duration', style: VerdantTypography.bodyMedium),
                        Text('45 mins', style: VerdantTypography.titleMedium),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              VerdantButton(
                label: 'Return to Dashboard',
                onPressed: () {
                  context.go('/dashboard');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
