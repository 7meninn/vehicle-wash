import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/dispute_provider.dart';

class CreateDisputePage extends ConsumerStatefulWidget {
  final String bookingId;

  const CreateDisputePage({super.key, required this.bookingId});

  @override
  ConsumerState<CreateDisputePage> createState() => _CreateDisputePageState();
}

class _CreateDisputePageState extends ConsumerState<CreateDisputePage> {
  final _descriptionController = TextEditingController();
  String _selectedType = 'BAD_WASH';
  bool _isLoading = false;

  final List<String> _disputeTypes = [
    'BAD_WASH',
    'SERVICE_INCOMPLETE',
    'VEHICLE_NOT_FOUND',
    'CUSTOMER_NOT_REACHABLE',
    'PROPERTY_ACCESS_DENIED',
    'OTHER'
  ];

  Future<void> _submitDispute() async {
    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a description')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final useCase = ref.read(createDisputeUseCaseProvider);
      await useCase(widget.bookingId, _selectedType, _descriptionController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dispute created successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raise Dispute')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: _disputeTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.replaceAll('_', ' ')));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedType = val!;
                });
              },
              decoration: const InputDecoration(labelText: 'Dispute Type'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitDispute,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Submit Dispute'),
            ),
          ],
        ),
      ),
    );
  }
}