import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/booking_provider.dart';

class SelectTimeScreen extends ConsumerStatefulWidget {
  const SelectTimeScreen({super.key});

  @override
  ConsumerState<SelectTimeScreen> createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends ConsumerState<SelectTimeScreen> {
  // Mock data
  final List<String> _dates = ['Today, Oct 24', 'Tomorrow, Oct 25', 'Friday, Oct 26'];
  final List<String> _times = ['09:00 AM', '11:00 AM', '01:00 PM', '03:00 PM'];
  
  String? _selectedDate;
  String? _selectedTime;

  void _handleNext() {
    if (_selectedDate != null && _selectedTime != null) {
      ref.read(bookingProvider.notifier).setTime(
        "2026-08-12", // mock date
        "slot_123", // mock slotId
      );
      context.push('/booking/estimate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Wash - Step 3')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Time',
                style: VerdantTypography.headlineMedium,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'When would you like the wash?',
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding / 2),
              
              Text('DATE', style: VerdantTypography.labelMedium),
              const SizedBox(height: VerdantSpacing.base),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _dates.length,
                  separatorBuilder: (_, __) => const SizedBox(width: VerdantSpacing.gap),
                  itemBuilder: (context, index) {
                    final date = _dates[index];
                    final isSelected = date == _selectedDate;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedDate = date),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? VerdantColors.warmSand : VerdantColors.surfaceElevated,
                          borderRadius: VerdantRadius.smallRadius,
                          border: Border.all(color: VerdantColors.border),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          date,
                          style: VerdantTypography.titleMedium.copyWith(
                            color: isSelected ? VerdantColors.obsidian : VerdantColors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: VerdantSpacing.gap * 2),
              Text('TIME SLOT', style: VerdantTypography.labelMedium),
              const SizedBox(height: VerdantSpacing.base),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: VerdantSpacing.gap,
                    mainAxisSpacing: VerdantSpacing.gap,
                  ),
                  itemCount: _times.length,
                  itemBuilder: (context, index) {
                    final time = _times[index];
                    final isSelected = time == _selectedTime;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTime = time),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? VerdantColors.warmSand : VerdantColors.surfaceElevated,
                          borderRadius: VerdantRadius.smallRadius,
                          border: Border.all(color: VerdantColors.border),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          time,
                          style: VerdantTypography.titleMedium.copyWith(
                            color: isSelected ? VerdantColors.obsidian : VerdantColors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              VerdantButton(
                label: 'View Estimate',
                onPressed: (_selectedDate == null || _selectedTime == null) ? () {} : _handleNext,
                variant: (_selectedDate == null || _selectedTime == null) ? VerdantButtonVariant.secondary : VerdantButtonVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
