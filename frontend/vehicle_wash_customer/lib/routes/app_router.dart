import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/authentication/presentation/pages/splash_screen.dart';
import '../features/authentication/presentation/pages/login_screen.dart';
import '../features/authentication/presentation/pages/otp_screen.dart';
import '../features/vehicle/presentation/pages/vehicle_list_screen.dart';
import '../features/vehicle/presentation/pages/add_vehicle_screen.dart';
import '../features/address/presentation/pages/address_list_screen.dart';
import '../features/address/presentation/pages/add_address_screen.dart';
import '../features/booking/presentation/pages/select_vehicle_screen.dart';
import '../features/booking/presentation/pages/select_address_screen.dart';
import '../features/booking/presentation/pages/select_time_screen.dart';
import '../features/booking/presentation/pages/price_estimate_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final mobile = state.extra as String? ?? '';
        return OtpScreen(mobileNumber: mobile);
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => context.push('/booking/select-vehicle'),
                child: const Text('Book a Wash'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.push('/vehicles'),
                child: const Text('My Vehicles'),
              ),
              ElevatedButton(
                onPressed: () => context.push('/addresses'),
                child: const Text('My Addresses'),
              ),
            ],
          ),
        ),
      ),
    ),
    GoRoute(
      path: '/vehicles',
      builder: (context, state) => const VehicleListScreen(),
    ),
    GoRoute(
      path: '/vehicles/add',
      builder: (context, state) => const AddVehicleScreen(),
    ),
    GoRoute(
      path: '/addresses',
      builder: (context, state) => const AddressListScreen(),
    ),
    GoRoute(
      path: '/addresses/add',
      builder: (context, state) => const AddAddressScreen(),
    ),
    GoRoute(
      path: '/booking/select-vehicle',
      builder: (context, state) => const SelectVehicleScreen(),
    ),
    GoRoute(
      path: '/booking/select-address',
      builder: (context, state) => const SelectAddressScreen(),
    ),
    GoRoute(
      path: '/booking/select-time',
      builder: (context, state) => const SelectTimeScreen(),
    ),
    GoRoute(
      path: '/booking/estimate',
      builder: (context, state) => const PriceEstimateScreen(),
    ),
  ],
);
