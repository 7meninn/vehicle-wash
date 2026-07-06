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
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Address',
                style: VerdantTypography.headlineMedium,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Where should the washer meet you?',
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding / 2),
              Expanded(
                child: ListView.separated(
                  itemCount: _addresses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: VerdantSpacing.gap),
                  itemBuilder: (context, index) {
                    final a = _addresses[index];
                    final isSelected = a['id'] == _selectedAddressId;
                    return VerdantCard(
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
                            color: isSelected ? VerdantColors.warmSand : VerdantColors.textSecondary,
                          ),
                          const SizedBox(width: VerdantSpacing.gap),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a['label']!, style: VerdantTypography.titleLarge),
                                const SizedBox(height: 4),
                                Text(a['details']!, style: VerdantTypography.bodyMedium),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              VerdantButton(
                label: 'Continue to Schedule',
                onPressed: _selectedAddressId == null ? () {} : _handleNext,
                variant: _selectedAddressId == null ? VerdantButtonVariant.secondary : VerdantButtonVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
