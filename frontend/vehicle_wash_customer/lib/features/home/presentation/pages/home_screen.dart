import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import '../../history/presentation/pages/booking_history_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const _DashboardTab(),
    const BookingHistoryTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? 'Vehicle Wash' : 'My Bookings',
          style: VerdantTypography.headlineMedium,
        ),
        backgroundColor: VerdantColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: VerdantColors.textPrimary),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
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

