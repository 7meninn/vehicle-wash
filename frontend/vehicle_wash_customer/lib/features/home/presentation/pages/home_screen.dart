import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import '../../../profile/presentation/pages/profile_screen.dart';

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
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: theme.colorScheme.primary.withOpacity(0.1))),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) => setState(() => _currentIndex = index),
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_outlined),
              selectedIcon: Icon(Icons.history),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Back',
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall,
            ),
            const SizedBox(height: EnterpriseSpacing.sectionPadding),
            EnterpriseButton(
              label: 'Book a Wash',
              onPressed: () => context.push('/booking/select-vehicle'),
            ),
            const SizedBox(height: EnterpriseSpacing.gap),
            EnterpriseButton(
              label: 'My Vehicles',
              variant: EnterpriseButtonVariant.secondary,
              onPressed: () => context.push('/vehicles'),
            ),
            const SizedBox(height: EnterpriseSpacing.gap),
            EnterpriseButton(
              label: 'My Addresses',
              variant: EnterpriseButtonVariant.secondary,
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
    final theme = Theme.of(context);
    
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            floating: false,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: Text(
                'My Bookings',
                style: theme.textTheme.headlineMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: EnterpriseSpacing.cardPadding),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildBookingCard(
                  context,
                  status: 'Active',
                  service: 'Premium Wash',
                  date: 'Tomorrow, 09:00 AM',
                  vehicle: 'Toyota Camry (ABC-1234)',
                  price: '\$59.00',
                  isActive: true,
                ),
                const SizedBox(height: EnterpriseSpacing.gap),
                _buildBookingCard(
                  context,
                  status: 'Completed',
                  service: 'Standard Wash',
                  date: 'Oct 12, 10:00 AM',
                  vehicle: 'Honda CR-V (XYZ-9876)',
                  price: '\$45.00',
                  isActive: false,
                ),
                const SizedBox(height: EnterpriseSpacing.gap),
                _buildBookingCard(
                  context,
                  status: 'Completed',
                  service: 'Premium Wash',
                  date: 'Sep 28, 02:00 PM',
                  vehicle: 'Toyota Camry (ABC-1234)',
                  price: '\$59.00',
                  isActive: false,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(
    BuildContext context, {
    required String status,
    required String service,
    required String date,
    required String vehicle,
    required String price,
    bool isActive = false,
  }) {
    final theme = Theme.of(context);
    
    return EnterpriseCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive ? theme.colorScheme.primary.withOpacity(0.1) : theme.colorScheme.surface,
                  borderRadius: EnterpriseRadius.smallRadius,
                  border: Border.all(
                    color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.2),
                  ),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
              Text(price, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: EnterpriseSpacing.gap * 1.5),
          Text(service, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 16, color: theme.colorScheme.onSurface.withOpacity(0.6)),
              const SizedBox(width: 8),
              Text(date, style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.directions_car_outlined, size: 16, color: theme.colorScheme.onSurface.withOpacity(0.6)),
              const SizedBox(width: 8),
              Text(vehicle, style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
