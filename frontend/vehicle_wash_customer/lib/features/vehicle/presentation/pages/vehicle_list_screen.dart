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
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _navigateToAddVehicle,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car_outlined, size: 64, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            const SizedBox(height: EnterpriseSpacing.gap),
            Text(
              'No vehicles yet.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: EnterpriseSpacing.base),
            Text(
              'Add your first car to get started with booking a wash.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: EnterpriseSpacing.sectionPadding),
            EnterpriseButton(
              label: 'Add a Vehicle',
              variant: EnterpriseButtonVariant.secondary,
              onPressed: _navigateToAddVehicle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
      itemCount: _vehicles.length,
      separatorBuilder: (_, __) => const SizedBox(height: EnterpriseSpacing.gap),
      itemBuilder: (context, index) {
        final v = _vehicles[index];
        return EnterpriseCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: EnterpriseColors.whiteTransparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.directions_car, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: EnterpriseSpacing.gap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${v['make']} ${v['model']}', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(v['plate'] ?? '', style: Theme.of(context).textTheme.labelMedium),
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
