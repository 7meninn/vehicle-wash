import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import '../providers/history_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Basic fetch without filters
    final historyAsyncValue = ref.watch(bookingHistoryProvider(const {'page': 0, 'size': 20}));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      body: historyAsyncValue.when(
        data: (bookings) {
          if (bookings.isEmpty) {
            return const Center(child: Text('No bookings yet.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
            itemCount: bookings.length,
            separatorBuilder: (context, index) => const SizedBox(height: VerdantSpacing.gap),
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return VerdantCard(
                padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Booking #${booking.bookingId.substring(0, 8)}', style: VerdantTypography.titleMedium),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: VerdantColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            booking.status,
                            style: VerdantTypography.labelSmall.copyWith(color: VerdantColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: VerdantSpacing.gap),
                    Text('Date: ${booking.bookingDate}', style: VerdantTypography.bodyMedium),
                    Text('Slot: ${booking.slot}', style: VerdantTypography.bodyMedium),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading history: $error')),
      ),
    );
  }
}
