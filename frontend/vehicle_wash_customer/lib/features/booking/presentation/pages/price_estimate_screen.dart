import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class PriceEstimateScreen extends StatelessWidget {
  const PriceEstimateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review & Confirm')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Price Estimate',
                style: VerdantTypography.headlineMedium,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Review the charges before finalizing your booking.',
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding / 2),
              
              VerdantCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildRow('Base Wash Price', '\$45.00'),
                    const SizedBox(height: VerdantSpacing.gap),
                    _buildRow('Travel Charge', '\$5.00'),
                    const SizedBox(height: VerdantSpacing.gap),
                    _buildRow('GST (18%)', '\$9.00'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: VerdantSpacing.gap),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: VerdantTypography.titleLarge),
                        Text(
                          '\$59.00',
                          style: VerdantTypography.headlineLarge.copyWith(color: VerdantColors.warmSand),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              VerdantButton(
                label: 'Confirm Booking',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Booking Confirmed!')),
                  );
                  context.go('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: VerdantTypography.bodyLarge),
        Text(amount, style: VerdantTypography.titleMedium),
      ],
    );
  }
}
