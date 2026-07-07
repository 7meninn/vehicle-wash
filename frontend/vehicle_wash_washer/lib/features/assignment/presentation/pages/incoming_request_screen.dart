import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class IncomingRequestScreen extends StatelessWidget {
  const IncomingRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VerdantColors.surfaceElevated, // Darker background for urgency
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              
              // Pulsing/Urgent visual
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: VerdantColors.warmSand.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_active,
                    size: 80,
                    color: VerdantColors.warmSand,
                  ),
                ),
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding / 2),
              
              Text(
                'New Booking Request!',
                textAlign: TextAlign.center,
                style: VerdantTypography.displaySmall,
              ),
              const SizedBox(height: VerdantSpacing.gap * 2),
              
              VerdantCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(Icons.directions_car, 'Toyota Camry (ABC-1234)'),
                    const SizedBox(height: VerdantSpacing.gap),
                    _buildDetailRow(Icons.location_on, '123 Main St, Springfield (2.4 miles)'),
                    const SizedBox(height: VerdantSpacing.gap),
                    _buildDetailRow(Icons.local_offer, 'Premium Wash'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: VerdantSpacing.gap),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Estimated Payout', style: VerdantTypography.bodyLarge),
                        Text('\$42.00', style: VerdantTypography.headlineLarge.copyWith(color: VerdantColors.warmSand)),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              Row(
                children: [
                  Expanded(
                    child: VerdantButton(
                      label: 'Decline',
                      variant: VerdantButtonVariant.ghost,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      onPressed: () {
                        context.go('/dashboard');
                      },
                    ),
                  ),
                  const SizedBox(width: VerdantSpacing.gap),
                  Expanded(
                    child: VerdantButton(
                      label: 'Accept Job',
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      onPressed: () {
                        context.go('/job/current');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: VerdantSpacing.gap),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: VerdantColors.textSecondary, size: 24),
        const SizedBox(width: VerdantSpacing.gap),
        Expanded(
          child: Text(
            text,
            style: VerdantTypography.titleMedium,
          ),
        ),
      ],
    );
  }
}
