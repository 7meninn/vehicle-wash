import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dispute_provider.dart';

class DisputeDetailsPage extends ConsumerWidget {
  final String disputeId;

  const DisputeDetailsPage({super.key, required this.disputeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disputeState = ref.watch(disputeDetailProvider(disputeId));

    return Scaffold(
      appBar: AppBar(title: const Text('Dispute Details')),
      body: disputeState.when(
        data: (dispute) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                Text('Type: '),
                const SizedBox(height: 8),
                Text('Description: '),
                const SizedBox(height: 16),
                if (dispute.adminResolution != null) ...[
                  const Text('Resolution:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(dispute.adminResolution!),
                ],
                const SizedBox(height: 16),
                const Text('Evidence:', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: dispute.evidenceList.length,
                    itemBuilder: (context, index) {
                      final ev = dispute.evidenceList[index];
                      return ListTile(
                        leading: const Icon(Icons.image),
                        title: Text('Evidence '),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: ')),
      ),
    );
  }
}