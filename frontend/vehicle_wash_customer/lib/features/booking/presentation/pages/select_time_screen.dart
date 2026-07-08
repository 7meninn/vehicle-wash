import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class SelectTimeScreen extends StatefulWidget {
  const SelectTimeScreen({super.key});

  @override
  State<SelectTimeScreen> createState() => _SelectTimeScreenState();
}

class _SelectTimeScreenState extends State<SelectTimeScreen> {
  // Mock data
  final List<String> _dates = ['Today, Oct 24', 'Tomorrow, Oct 25', 'Friday, Oct 26'];
  final List<String> _times = ['09:00 AM', '11:00 AM', '01:00 PM', '03:00 PM'];
  
  String? _selectedDate;
  String? _selectedTime;

  void _handleNext() {
    if (_selectedDate != null && _selectedTime != null) {
      context.push('/booking/estimate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Wash - Step 3')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Time',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: EnterpriseSpacing.base),
              Text(
                'When would you like the wash?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: EnterpriseSpacing.sectionPadding / 2),
              
              Text('DATE', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: EnterpriseSpacing.base),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _dates.length,
                  separatorBuilder: (_, __) => const SizedBox(width: EnterpriseSpacing.gap),
                  itemBuilder: (context, index) {
                    final date = _dates[index];
                    final isSelected = date == _selectedDate;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedDate = date),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                          borderRadius: EnterpriseRadius.smallRadius,
                          border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          date,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: EnterpriseSpacing.gap * 2),
              Text('TIME SLOT', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: EnterpriseSpacing.base),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: EnterpriseSpacing.gap,
                    mainAxisSpacing: EnterpriseSpacing.gap,
                  ),
                  itemCount: _times.length,
                  itemBuilder: (context, index) {
                    final time = _times[index];
                    final isSelected = time == _selectedTime;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTime = time),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                          borderRadius: EnterpriseRadius.smallRadius,
                          border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          time,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isSelected ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              EnterpriseButton(
                label: 'View Estimate',
                onPressed: (_selectedDate == null || _selectedTime == null) ? () {} : _handleNext,
                variant: (_selectedDate == null || _selectedTime == null) ? EnterpriseButtonVariant.secondary : EnterpriseButtonVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
