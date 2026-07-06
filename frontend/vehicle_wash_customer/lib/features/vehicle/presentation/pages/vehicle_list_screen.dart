import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  // Mock data state
  List<Map<String, String>> _vehicles = [];

  void _navigateToAddVehicle() async {
    final result = await context.push('/vehicles/add');
    if (result == true) {
      setState(() {
        _vehicles.add({
          'make': 'Toyota',
          'model': 'Camry',
          'plate': 'ABC-1234',
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vehicles'),
      ),
      body: SafeArea(
        child: _vehicles.isEmpty ? _buildEmptyState() : _buildList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: VerdantColors.warmSand,
        onPressed: _navigateToAddVehicle,
        child: const Icon(Icons.add, color: VerdantColors.obsidian),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions_car_outlined, size: 64, color: VerdantColors.textSecondary),
            const SizedBox(height: VerdantSpacing.gap),
            Text(
              'No vehicles yet.',
              style: VerdantTypography.headlineMedium,
            ),
            const SizedBox(height: VerdantSpacing.base),
            Text(
              'Add your first car to get started with booking a wash.',
              textAlign: TextAlign.center,
              style: VerdantTypography.bodyLarge,
            ),
            const SizedBox(height: VerdantSpacing.sectionPadding),
            VerdantButton(
              label: 'Add a Vehicle',
              variant: VerdantButtonVariant.secondary,
              onPressed: _navigateToAddVehicle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
      itemCount: _vehicles.length,
      separatorBuilder: (_, __) => const SizedBox(height: VerdantSpacing.gap),
      itemBuilder: (context, index) {
        final v = _vehicles[index];
        return VerdantCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: VerdantColors.whiteTransparent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.directions_car, color: VerdantColors.warmSand),
              ),
              const SizedBox(width: VerdantSpacing.gap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${v['make']} ${v['model']}', style: VerdantTypography.titleLarge),
                    const SizedBox(height: 4),
                    Text(v['plate'] ?? '', style: VerdantTypography.labelMedium),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () {
                  setState(() {
                    _vehicles.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
