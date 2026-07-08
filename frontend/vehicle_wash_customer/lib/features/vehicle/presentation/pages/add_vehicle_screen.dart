import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _colorController = TextEditingController();
  final _licensePlateController = TextEditingController();

  void _handleSave() {
    if (_makeController.text.isEmpty || _modelController.text.isEmpty || _licensePlateController.text.isEmpty) {
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
    _makeController.dispose();
    _modelController.dispose();
    _colorController.dispose();
    _licensePlateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
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
                      label: 'Make',
                      hintText: 'e.g. Toyota',
                      controller: _makeController,
                    ),
                    const SizedBox(height: EnterpriseSpacing.gap),
                    EnterpriseTextField(
                      label: 'Model',
                      hintText: 'e.g. Camry',
                      controller: _modelController,
                    ),
                    const SizedBox(height: EnterpriseSpacing.gap),
                    EnterpriseTextField(
                      label: 'Color',
                      hintText: 'e.g. Midnight Blue',
                      controller: _colorController,
                    ),
                    const SizedBox(height: EnterpriseSpacing.gap),
                    EnterpriseTextField(
                      label: 'License Plate',
                      hintText: 'ABC-1234',
                      controller: _licensePlateController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: EnterpriseSpacing.sectionPadding),
              EnterpriseButton(
                label: 'Save Vehicle',
                onPressed: _handleSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
