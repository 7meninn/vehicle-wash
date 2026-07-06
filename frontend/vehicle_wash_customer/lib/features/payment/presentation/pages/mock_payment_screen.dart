import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class MockPaymentScreen extends StatelessWidget {
  const MockPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.credit_card, size: 80, color: VerdantColors.textSecondary),
              const SizedBox(height: VerdantSpacing.gap * 2),
              Text(
                'Simulate Payment',
                textAlign: TextAlign.center,
                style: VerdantTypography.headlineLarge,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'This is a mock gateway since real payment processing is not yet integrated.',
                textAlign: TextAlign.center,
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding),
              
              VerdantButton(
                label: 'Pay Success',
                onPressed: () {
                  context.push('/booking/confirmed');
                },
              ),
              const SizedBox(height: VerdantSpacing.gap),
              VerdantButton(
                label: 'Pay Fail',
                variant: VerdantButtonVariant.secondary,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment Failed. Please try again.')),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
