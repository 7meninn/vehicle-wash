import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _labelController = TextEditingController();
  final _addressLineController = TextEditingController();
  final _cityController = TextEditingController();

  void _handleSave() {
    if (_labelController.text.isEmpty || _addressLineController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }
    // Mock save
    context.pop(true);
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressLineController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EnterpriseCard(
                child: Column(
                  children: [
                    EnterpriseTextField(
                      label: 'Label',
                      hintText: 'e.g. Home, Office',
                      controller: _labelController,
                    ),
                    const SizedBox(height: EnterpriseSpacing.gap),
                    EnterpriseTextField(
                      label: 'Address Line',
                      hintText: 'e.g. 123 Main St, Apt 4B',
                      controller: _addressLineController,
                    ),
                    const SizedBox(height: EnterpriseSpacing.gap),
                    EnterpriseTextField(
                      label: 'City',
                      hintText: 'e.g. Springfield',
                      controller: _cityController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: EnterpriseSpacing.sectionPadding),
              EnterpriseButton(
                label: 'Save Address',
                onPressed: _handleSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
