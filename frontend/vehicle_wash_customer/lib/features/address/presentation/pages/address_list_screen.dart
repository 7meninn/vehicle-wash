import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  // Mock data state
  List<Map<String, String>> _addresses = [];

  void _navigateToAddAddress() async {
    final result = await context.push('/addresses/add');
    if (result == true) {
      setState(() {
        _addresses.add({
          'label': 'Home',
          'line': '123 Main St, Apt 4B',
          'city': 'Springfield',
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      body: SafeArea(
        child: _addresses.isEmpty ? _buildEmptyState() : _buildList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _navigateToAddAddress,
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
            Icon(Icons.location_on_outlined, size: 64, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            const SizedBox(height: EnterpriseSpacing.gap),
            Text(
              'No addresses yet.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: EnterpriseSpacing.base),
            Text(
              'Add a saved address to speed up booking.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: EnterpriseSpacing.sectionPadding),
            EnterpriseButton(
              label: 'Add an Address',
              variant: EnterpriseButtonVariant.secondary,
              onPressed: _navigateToAddAddress,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
      itemCount: _addresses.length,
      separatorBuilder: (_, __) => const SizedBox(height: EnterpriseSpacing.gap),
      itemBuilder: (context, index) {
        final a = _addresses[index];
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
                child: Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: EnterpriseSpacing.gap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a['label'] ?? '', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text('${a['line']}, ${a['city']}', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () {
                  setState(() {
                    _addresses.removeAt(index);
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
