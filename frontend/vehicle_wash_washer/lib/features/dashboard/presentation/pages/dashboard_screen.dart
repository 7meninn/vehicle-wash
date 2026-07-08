import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Washer Dashboard',
          style: VerdantTypography.headlineMedium,
        ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: VerdantColors.textPrimary),
            onPressed: () {},
          ).animate().scale(delay: 200.ms, duration: 300.ms),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: VerdantSpacing.cardPadding, vertical: VerdantSpacing.gap),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAvailabilityToggle().animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
                  const SizedBox(height: VerdantSpacing.gap * 2),
                  _buildEarningsSummary().animate().fadeIn(delay: 150.ms, duration: 500.ms).slideY(begin: 0.1),
                  const SizedBox(height: VerdantSpacing.gap * 2),
                  _buildSectionHeader('Today\'s Jobs').animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: VerdantSpacing.base),
                  _buildJobCard('Premium Wash', '10:00 AM', '123 Main St, Springfield')
                      .animate().fadeIn(delay: 400.ms, duration: 400.ms).slideX(begin: 0.1),
                  const SizedBox(height: VerdantSpacing.base),
                  _buildJobCard('Standard Wash', '01:00 PM', '456 Elm St, Springfield')
                      .animate().fadeIn(delay: 500.ms, duration: 400.ms).slideX(begin: 0.1),
                  
                  const SizedBox(height: VerdantSpacing.gap * 2),
                  _buildSectionHeader('Booking Requests').animate().fadeIn(delay: 600.ms),
                  const SizedBox(height: VerdantSpacing.base),
                  _buildRequestCard('Deep Clean', 'Tomorrow, 09:00 AM', '789 Oak St, Springfield')
                      .animate().fadeIn(delay: 700.ms, duration: 400.ms).scale(begin: const Offset(0.95, 0.95)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAvailabilityToggle() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(VerdantSpacing.cardRadius),
        gradient: LinearGradient(
          colors: _isOnline 
              ? [VerdantColors.primary, VerdantColors.primaryLight]
              : [VerdantColors.surfaceLight, VerdantColors.surfaceMedium],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          if (_isOnline)
            BoxShadow(
              color: VerdantColors.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: VerdantTypography.labelMedium.copyWith(
                      color: _isOnline ? Colors.white70 : VerdantColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isOnline ? Colors.white : Colors.redAccent,
                          boxShadow: [
                            if (_isOnline)
                              BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 4)
                          ]
                        ),
                      ).animate(target: _isOnline ? 1 : 0).shimmer(duration: 1000.ms, color: Colors.white),
                      const SizedBox(width: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          _isOnline ? 'Online - Ready for jobs' : 'Offline',
                          key: ValueKey<bool>(_isOnline),
                          style: VerdantTypography.titleMedium.copyWith(
                            color: _isOnline ? Colors.white : VerdantColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit_location_alt_outlined, 
                      color: _isOnline ? Colors.white : VerdantColors.textPrimary
                    ),
                    tooltip: 'Service Areas',
                    onPressed: () => context.push('/availability/service-areas'),
                  ),
                  Switch(
                    value: _isOnline,
                    activeColor: Colors.white,
                    activeTrackColor: VerdantColors.primaryDark,
                    inactiveThumbColor: VerdantColors.textSecondary,
                    onChanged: (val) {
                      setState(() {
                        _isOnline = val;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsSummary() {
    return VerdantCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TODAY\'S EARNINGS',
                style: VerdantTypography.labelMedium.copyWith(letterSpacing: 1.2),
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                '\$124.50',
                style: VerdantTypography.displayMedium.copyWith(
                  color: VerdantColors.warmSand,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: VerdantColors.warmSand.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: VerdantColors.warmSand,
              size: 32,
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .moveY(begin: -4, end: 4, duration: 2.seconds),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: VerdantTypography.headlineMedium.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildJobCard(String service, String time, String address) {
    return VerdantCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: VerdantColors.primaryLight.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.local_car_wash, color: VerdantColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service, style: VerdantTypography.titleLarge.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: VerdantColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(time, style: VerdantTypography.bodyMedium),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on_outlined, size: 14, color: VerdantColors.textSecondary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        address, 
                        style: VerdantTypography.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16, color: VerdantColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildRequestCard(String service, String time, String address) {
    return VerdantCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'NEW REQUEST',
                  style: VerdantTypography.labelSmall.copyWith(color: Colors.orange, fontWeight: FontWeight.bold),
                ),
              ).animate().shimmer(duration: 1200.ms, delay: 1.seconds),
              const Spacer(),
              Text('2 mins ago', style: VerdantTypography.labelMedium),
            ],
          ),
          const SizedBox(height: 12),
          Text(service, style: VerdantTypography.titleLarge.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16, color: VerdantColors.textSecondary),
              const SizedBox(width: 6),
              Text(time, style: VerdantTypography.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: VerdantColors.textSecondary),
              const SizedBox(width: 6),
              Text(address, style: VerdantTypography.bodyMedium),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: VerdantButton(
                  label: 'Dismiss',
                  variant: VerdantButtonVariant.secondary,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: VerdantSpacing.gap),
              Expanded(
                child: VerdantButton(
                  label: 'View',
                  onPressed: () {
                    context.push('/assignment/incoming');
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
