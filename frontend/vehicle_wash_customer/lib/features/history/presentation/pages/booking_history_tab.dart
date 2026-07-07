import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

import '../providers/history_provider.dart';

class BookingHistoryTab extends ConsumerWidget {
  const BookingHistoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(bookingHistoryProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Bookings',
              style: VerdantTypography.headlineMedium,
            ),
            const SizedBox(height: VerdantSpacing.gap * 2),
            Expanded(
              child: historyState.when(
                loading: () => const Center(child: CircularProgressIndicator(color: VerdantColors.warmSand)),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $error', style: VerdantTypography.bodyLarge),
                      const SizedBox(height: VerdantSpacing.gap),
                      VerdantButton(
                        label: 'Retry',
                        onPressed: () => ref.read(bookingHistoryProvider.notifier).refreshHistory(),
                      ),
                    ],
                  ),
                ),
                data: (bookings) {
                  if (bookings.isEmpty) {
                    return const Center(
                      child: Text('No bookings yet.\nBook your first wash.'),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => ref.read(bookingHistoryProvider.notifier).refreshHistory(),
                    child: ListView.separated(
                      itemCount: bookings.length,
                      separatorBuilder: (context, index) => const SizedBox(height: VerdantSpacing.gap),
                      itemBuilder: (context, index) {
                        final booking = bookings[index];
                        final isPast = booking.status == 'COMPLETED' || booking.status == 'CANCELLED';
                        
                        final dt = booking.date;
                        final dateStr = '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                        
                        return _buildBookingCard(
                          status: booking.status,
                          service: booking.service,
                          date: dateStr,
                          vehicle: booking.vehicle,
                          price: '\$${booking.price.toStringAsFixed(2)}',
                          isPast: isPast,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard({
    required String status,
    required String service,
    required String date,
    required String vehicle,
    required String price,
    bool isPast = false,
  }) {
    return VerdantCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPast ? VerdantColors.surfaceElevated : VerdantColors.warmSand.withOpacity(0.2),
                  borderRadius: VerdantRadius.smallRadius,
                  border: Border.all(
                    color: isPast ? VerdantColors.border : VerdantColors.warmSand,
                  ),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: VerdantTypography.labelSmall.copyWith(
                    color: isPast ? VerdantColors.textSecondary : VerdantColors.warmSand,
                  ),
                ),
              ),
              Text(price, style: VerdantTypography.titleMedium),
            ],
          ),
          const SizedBox(height: VerdantSpacing.gap),
          Text(service, style: VerdantTypography.titleLarge),
          const SizedBox(height: 4),
          Text(date, style: VerdantTypography.bodyLarge),
          const SizedBox(height: 4),
          Text(vehicle, style: VerdantTypography.bodyMedium),
        ],
      ),
    );
  }
}
