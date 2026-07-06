import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class ServiceAreasScreen extends StatefulWidget {
  const ServiceAreasScreen({super.key});

  @override
  State<ServiceAreasScreen> createState() => _ServiceAreasScreenState();
}

class _ServiceAreasScreenState extends State<ServiceAreasScreen> {
  final TextEditingController _pincodeController = TextEditingController();
  final List<String> _serviceAreas = ['90210', '90211', '90212'];

  void _handleAddPincode() {
    final code = _pincodeController.text.trim();
    if (code.isNotEmpty && !_serviceAreas.contains(code)) {
      setState(() {
        _serviceAreas.add(code);
        _pincodeController.clear();
      });
    }
  }

  void _handleRemovePincode(String code) {
    setState(() {
      _serviceAreas.remove(code);
    });
  }

  @override
  void dispose() {
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Areas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Where do you work?',
                style: VerdantTypography.headlineMedium,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Add pincodes or neighborhoods you are willing to travel to for wash appointments.',
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding / 2),
              VerdantCard(
                child: Column(
                  children: [
                    VerdantTextField(
                      label: 'Add Pincode / Area Code',
                      hintText: 'e.g. 90210',
                      controller: _pincodeController,
                      keyboardType: TextInputType.number,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add, color: VerdantColors.warmSand),
                        onPressed: _handleAddPincode,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: VerdantSpacing.gap * 2),
              Text(
                'Active Areas',
                style: VerdantTypography.titleLarge,
              ),
              const SizedBox(height: VerdantSpacing.gap),
              Expanded(
                child: _serviceAreas.isEmpty
                    ? Center(
                        child: Text(
                          'No service areas added.',
                          style: VerdantTypography.bodyMedium,
                        ),
                      )
                    : ListView.separated(
                        itemCount: _serviceAreas.length,
                        separatorBuilder: (_, __) => const SizedBox(height: VerdantSpacing.gap),
                        itemBuilder: (context, index) {
                          final area = _serviceAreas[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: VerdantColors.surfaceElevated,
                              borderRadius: VerdantRadius.smallRadius,
                              border: Border.all(color: VerdantColors.border),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: VerdantColors.warmSand, size: 20),
                                    const SizedBox(width: 12),
                                    Text(area, style: VerdantTypography.bodyLarge),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.redAccent, size: 20),
                                  onPressed: () => _handleRemovePincode(area),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
