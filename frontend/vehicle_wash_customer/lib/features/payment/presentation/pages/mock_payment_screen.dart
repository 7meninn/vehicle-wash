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
          padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.credit_card, size: 80, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              const SizedBox(height: EnterpriseSpacing.gap * 2),
              Text(
                'Simulate Payment',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: EnterpriseSpacing.base),
              Text(
                'This is a mock gateway since real payment processing is not yet integrated.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: EnterpriseSpacing.sectionPadding),
              
              EnterpriseButton(
                label: 'Pay Success',
                onPressed: () {
                  context.push('/booking/confirmed');
                },
              ),
              const SizedBox(height: EnterpriseSpacing.gap),
              EnterpriseButton(
                label: 'Pay Fail',
                variant: EnterpriseButtonVariant.secondary,
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
