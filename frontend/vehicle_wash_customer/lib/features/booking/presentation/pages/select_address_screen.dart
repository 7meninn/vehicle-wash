import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  // Mock data
  final List<Map<String, String>> _addresses = [
    {'id': '1', 'label': 'Home', 'details': '123 Main St, Springfield'},
    {'id': '2', 'label': 'Office', 'details': '456 Business Pkwy, Springfield'},
  ];
  String? _selectedAddressId;

  void _handleNext() {
    if (_selectedAddressId != null) {
      context.push('/booking/select-time');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Wash - Step 2')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Address',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: EnterpriseSpacing.base),
              Text(
                'Where should the washer meet you?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: EnterpriseSpacing.sectionPadding / 2),
              Expanded(
                child: ListView.separated(
                  itemCount: _addresses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: EnterpriseSpacing.gap),
                  itemBuilder: (context, index) {
                    final a = _addresses[index];
                    final isSelected = a['id'] == _selectedAddressId;
                    return EnterpriseCard(
                      padding: const EdgeInsets.all(16),
                      onTap: () {
                        setState(() {
                          _selectedAddressId = a['id'];
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: EnterpriseSpacing.gap),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a['label']!, style: Theme.of(context).textTheme.titleLarge),
                                const SizedBox(height: 4),
                                Text(a['details']!, style: Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              EnterpriseButton(
                label: 'Continue to Schedule',
                onPressed: _selectedAddressId == null ? () {} : _handleNext,
                variant: _selectedAddressId == null ? EnterpriseButtonVariant.secondary : EnterpriseButtonVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
