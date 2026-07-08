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
          padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Price Estimate',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: EnterpriseSpacing.base),
              Text(
                'Review the charges before finalizing your booking.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: EnterpriseSpacing.sectionPadding / 2),
              
              EnterpriseCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildRow(context, 'Base Wash Price', '\$45.00'),
                    const SizedBox(height: EnterpriseSpacing.gap),
                    _buildRow(context, 'Travel Charge', '\$5.00'),
                    const SizedBox(height: EnterpriseSpacing.gap),
                    _buildRow(context, 'GST (18%)', '\$9.00'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: EnterpriseSpacing.gap),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          '\$59.00',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              EnterpriseButton(
                label: 'Confirm Booking',
                onPressed: () {
                  context.push('/payment/mock');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        Text(amount, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
