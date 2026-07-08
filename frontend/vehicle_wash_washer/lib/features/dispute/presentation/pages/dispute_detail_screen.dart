import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dispute_provider.dart';

class DisputeDetailScreen extends ConsumerWidget {
  final String disputeId;

  const DisputeDetailScreen({super.key, required this.disputeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disputeState = ref.watch(disputeDetailProvider(disputeId));

    return Scaffold(
      appBar: AppBar(title: const Text('Dispute Details')),
      body: disputeState.when(
        data: (dispute) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Dispute ID', dispute.id),
                _buildInfoRow('Booking ID', dispute.bookingId),
                _buildInfoRow('Type', dispute.disputeType.replaceAll('_', ' ')),
                _buildInfoRow('Status', dispute.disputeStatus),
                _buildInfoRow('Raised By', dispute.raisedBy),
                _buildInfoRow('Date Raised', _formatDate(dispute.createdAt)),
                const Divider(height: 32),
                const Text('Issue Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text(dispute.issueDescription),
                const Divider(height: 32),
                if (dispute.adminResolution != null) ...[
                  const Text('Resolution', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(dispute.adminResolution!),
                  const SizedBox(height: 16),
                ],
                const Text('Evidence', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                if (dispute.evidenceList.isEmpty)
                  const Text('No evidence uploaded.')
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dispute.evidenceList.length,
                    itemBuilder: (context, index) {
                      final evidence = dispute.evidenceList[index];
                      return ListTile(
                        leading: const Icon(Icons.attachment),
                        title: Text(evidence.mediaType),
                        subtitle: Text('Uploaded on: ${_formatDate(evidence.uploadedAt)}'),
                      );
                    },
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading dispute: $err')),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
