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
        backgroundColor: VerdantColors.warmSand,
        onPressed: _navigateToAddAddress,
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
            const Icon(Icons.location_on_outlined, size: 64, color: VerdantColors.textSecondary),
            const SizedBox(height: VerdantSpacing.gap),
            Text(
              'No addresses yet.',
              style: VerdantTypography.headlineMedium,
            ),
            const SizedBox(height: VerdantSpacing.base),
            Text(
              'Add a saved address to speed up booking.',
              textAlign: TextAlign.center,
              style: VerdantTypography.bodyLarge,
            ),
            const SizedBox(height: VerdantSpacing.sectionPadding),
            VerdantButton(
              label: 'Add an Address',
              variant: VerdantButtonVariant.secondary,
              onPressed: _navigateToAddAddress,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
      itemCount: _addresses.length,
      separatorBuilder: (_, __) => const SizedBox(height: VerdantSpacing.gap),
      itemBuilder: (context, index) {
        final a = _addresses[index];
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
                child: const Icon(Icons.location_on, color: VerdantColors.warmSand),
              ),
              const SizedBox(width: VerdantSpacing.gap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a['label'] ?? '', style: VerdantTypography.titleLarge),
                    const SizedBox(height: 4),
                    Text('${a['line']}, ${a['city']}', style: VerdantTypography.bodyMedium),
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
