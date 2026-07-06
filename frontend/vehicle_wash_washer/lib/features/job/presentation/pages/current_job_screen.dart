import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

enum JobStatus { assigned, onTheWay, washStarted }

class CurrentJobScreen extends StatefulWidget {
  const CurrentJobScreen({super.key});

  @override
  State<CurrentJobScreen> createState() => _CurrentJobScreenState();
}

class _CurrentJobScreenState extends State<CurrentJobScreen> {
  JobStatus _status = JobStatus.assigned;

  void _handleAction() {
    setState(() {
      if (_status == JobStatus.assigned) {
        _status = JobStatus.onTheWay;
      } else if (_status == JobStatus.onTheWay) {
        _status = JobStatus.washStarted;
      } else if (_status == JobStatus.washStarted) {
        context.push('/job/media-upload');
      }
    });
  }

  String _getButtonLabel() {
    switch (_status) {
      case JobStatus.assigned:
        return 'Start Navigation';
      case JobStatus.onTheWay:
        return 'Arrived - Start Wash';
      case JobStatus.washStarted:
        return 'Finish & Upload Photos';
    }
  }

  String _getStatusText() {
    switch (_status) {
      case JobStatus.assigned:
        return 'Pending Arrival';
      case JobStatus.onTheWay:
        return 'On the way';
      case JobStatus.washStarted:
        return 'Washing in progress';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Job'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status Badge
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: VerdantColors.warmSand.withOpacity(0.2),
                    borderRadius: VerdantRadius.pillRadius,
                  ),
                  child: Text(
                    _getStatusText().toUpperCase(),
                    style: VerdantTypography.labelMedium.copyWith(color: VerdantColors.warmSand),
                  ),
                ),
              ),
              const SizedBox(height: VerdantSpacing.gap * 2),
              
              // Mock Map placeholder
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: VerdantColors.surfaceElevated,
                  borderRadius: VerdantRadius.innerRadius,
                  border: Border.all(color: VerdantColors.border),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map, size: 48, color: VerdantColors.textSecondary),
                      const SizedBox(height: 8),
                      Text('Map Navigation View', style: VerdantTypography.bodyMedium),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: VerdantSpacing.gap * 2),
              
              Text('Customer Details', style: VerdantTypography.headlineMedium),
              const SizedBox(height: VerdantSpacing.base),
              VerdantCard(
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: VerdantColors.whiteTransparent,
                      child: Icon(Icons.person, color: VerdantColors.warmSand),
                    ),
                    const SizedBox(width: VerdantSpacing.gap),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jane Smith', style: VerdantTypography.titleLarge),
                          const SizedBox(height: 4),
                          Text('Toyota Camry (ABC-1234)', style: VerdantTypography.bodyMedium),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.phone, color: VerdantColors.warmSand),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: VerdantSpacing.gap * 2),
              
              Text('Job Details', style: VerdantTypography.headlineMedium),
              const SizedBox(height: VerdantSpacing.base),
              VerdantCard(
                child: Column(
                  children: [
                    _buildRow('Service', 'Premium Wash'),
                    const SizedBox(height: VerdantSpacing.gap),
                    _buildRow('Address', '123 Main St, Springfield'),
                    const SizedBox(height: VerdantSpacing.gap),
                    _buildRow('Payout', '\$42.00'),
                  ],
                ),
              ),
              
              const SizedBox(height: VerdantSpacing.sectionPadding),
              
              VerdantButton(
                label: _getButtonLabel(),
                onPressed: _handleAction,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: VerdantTypography.bodyMedium),
        const SizedBox(width: VerdantSpacing.gap),
        Expanded(
          child: Text(
            value,
            style: VerdantTypography.titleMedium,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
