import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class SelectVehicleScreen extends StatefulWidget {
  const SelectVehicleScreen({super.key});

  @override
  State<SelectVehicleScreen> createState() => _SelectVehicleScreenState();
}

class _SelectVehicleScreenState extends State<SelectVehicleScreen> {
  // Mock data
  final List<Map<String, String>> _vehicles = [
    {'id': '1', 'name': 'Toyota Camry', 'plate': 'ABC-1234'},
    {'id': '2', 'name': 'Honda CR-V', 'plate': 'XYZ-9876'},
  ];
  String? _selectedVehicleId;

  void _handleNext() {
    if (_selectedVehicleId != null) {
      context.push('/booking/select-address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Wash - Step 1')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Vehicle',
                style: VerdantTypography.headlineMedium,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Which vehicle needs a wash today?',
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding / 2),
              Expanded(
                child: ListView.separated(
                  itemCount: _vehicles.length,
                  separatorBuilder: (_, __) => const SizedBox(height: VerdantSpacing.gap),
                  itemBuilder: (context, index) {
                    final v = _vehicles[index];
                    final isSelected = v['id'] == _selectedVehicleId;
                    return VerdantCard(
                      padding: const EdgeInsets.all(16),
                      onTap: () {
                        setState(() {
                          _selectedVehicleId = v['id'];
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
                                Text(v['name']!, style: VerdantTypography.titleLarge),
                                const SizedBox(height: 4),
                                Text(v['plate']!, style: VerdantTypography.bodyMedium),
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
                label: 'Continue to Address',
                onPressed: _selectedVehicleId == null ? () {} : _handleNext, // Disables if null visually handled by logic inside onPressed or variant
                variant: _selectedVehicleId == null ? VerdantButtonVariant.secondary : VerdantButtonVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
