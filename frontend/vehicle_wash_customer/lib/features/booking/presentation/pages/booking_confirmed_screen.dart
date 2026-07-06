import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: VerdantColors.whiteTransparent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 100,
                  color: Colors.greenAccent,
                ),
              ),
              const SizedBox(height: VerdantSpacing.gap * 2),
              Text(
                'Booking Confirmed!',
                textAlign: TextAlign.center,
                style: VerdantTypography.displaySmall,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Booking ID: #VW-847291',
                textAlign: TextAlign.center,
                style: VerdantTypography.labelLarge,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Your washer has been notified and will arrive at the scheduled time.',
                textAlign: TextAlign.center,
                style: VerdantTypography.bodyLarge,
              ),
              const Spacer(),
              VerdantButton(
                label: 'Track Booking',
                onPressed: () {
                  context.go('/home'); // Will go to home which has the history tab
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
