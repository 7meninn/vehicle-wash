import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class CurrentJobScreen extends StatelessWidget {
  const CurrentJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Job'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mock Map placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: VerdantColors.surfaceElevated,
                  borderRadius: VerdantRadius.innerRadius,
                  border: Border.all(color: VerdantColors.border),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map, size: 48, color: VerdantColors.textSecondary),
                      const SizedBox(height: 8),
                      Text('Map Navigation View', style: VerdantTypography.bodyMedium),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: VerdantSpacing.gap * 2),
              
              Text('Customer Details', style: VerdantTypography.headlineMedium),
              const SizedBox(height: VerdantSpacing.base),
              VerdantCard(
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: VerdantColors.whiteTransparent,
                      child: Icon(Icons.person, color: VerdantColors.warmSand),
                    ),
                    const SizedBox(width: VerdantSpacing.gap),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jane Smith', style: VerdantTypography.titleLarge),
                          const SizedBox(height: 4),
                          Text('Toyota Camry (ABC-1234)', style: VerdantTypography.bodyMedium),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone, color: VerdantColors.warmSand),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: VerdantSpacing.gap * 2),
              
              Text('Job Details', style: VerdantTypography.headlineMedium),
              const SizedBox(height: VerdantSpacing.base),
              VerdantCard(
                child: Column(
                  children: [
                    _buildRow('Service', 'Premium Wash'),
                    const SizedBox(height: VerdantSpacing.gap),
                    _buildRow('Address', '123 Main St, Springfield'),
                    const SizedBox(height: VerdantSpacing.gap),
                    _buildRow('Payout', '\$42.00'),
                  ],
                ),
              ),
              
              const SizedBox(height: VerdantSpacing.sectionPadding),
              
              VerdantButton(
                label: 'Complete Wash',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Job marked as completed!')),
                  );
                  context.go('/dashboard');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: VerdantTypography.bodyMedium),
        const SizedBox(width: VerdantSpacing.gap),
        Expanded(
          child: Text(
            value,
            style: VerdantTypography.titleMedium,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
