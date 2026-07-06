import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const _DashboardTab(),
    const _BookingHistoryTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: VerdantColors.warmSand,
        unselectedItemColor: VerdantColors.textSecondary,
        backgroundColor: VerdantColors.background,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Bookings',
          ),
        ],
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back',
              textAlign: TextAlign.center,
              style: VerdantTypography.displaySmall,
            ),
            const SizedBox(height: VerdantSpacing.sectionPadding),
            VerdantButton(
              label: 'Book a Wash',
              onPressed: () => context.push('/booking/select-vehicle'),
            ),
            const SizedBox(height: VerdantSpacing.gap),
            VerdantButton(
              label: 'My Vehicles',
              variant: VerdantButtonVariant.secondary,
              onPressed: () => context.push('/vehicles'),
            ),
            const SizedBox(height: VerdantSpacing.gap),
            VerdantButton(
              label: 'My Addresses',
              variant: VerdantButtonVariant.secondary,
              onPressed: () => context.push('/addresses'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingHistoryTab extends StatelessWidget {
  const _BookingHistoryTab();

  @override
  Widget build(BuildContext context) {
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
              child: ListView(
                children: [
                  _buildBookingCard(
                    status: 'Active',
                    service: 'Premium Wash',
                    date: 'Tomorrow, 09:00 AM',
                    vehicle: 'Toyota Camry (ABC-1234)',
                    price: '\$59.00',
                  ),
                  const SizedBox(height: VerdantSpacing.gap),
                  _buildBookingCard(
                    status: 'Completed',
                    service: 'Standard Wash',
                    date: 'Oct 12, 10:00 AM',
                    vehicle: 'Honda CR-V (XYZ-9876)',
                    price: '\$45.00',
                    isPast: true,
                  ),
                ],
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
