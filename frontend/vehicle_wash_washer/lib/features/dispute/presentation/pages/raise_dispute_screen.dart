import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dispute_provider.dart';

class RaiseDisputeScreen extends ConsumerStatefulWidget {
  final String bookingId;

  const RaiseDisputeScreen({super.key, required this.bookingId});

  @override
  ConsumerState<RaiseDisputeScreen> createState() => _RaiseDisputeScreenState();
}

class _RaiseDisputeScreenState extends ConsumerState<RaiseDisputeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'BAD_WASH';
  final _descriptionController = TextEditingController();

  final List<String> _disputeTypes = ['BAD_WASH', 'CUSTOMER_NO_SHOW', 'PAYMENT_ISSUE', 'OTHER'];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(disputeActionProvider.notifier).raiseDispute(
        bookingId: widget.bookingId,
        type: _selectedType,
        description: _descriptionController.text.trim(),
      ).then((_) {
        if (!mounted) return;
        final state = ref.read(disputeActionProvider);
        if (!state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dispute raised successfully')),
          );
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to raise dispute: ${state.error}')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(disputeActionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Raise Dispute')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                initialValue: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Dispute Type',
                  border: OutlineInputBorder(),
                ),
                items: _disputeTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.replaceAll('_', ' ')),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: actionState.isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: actionState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Submit Dispute', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
