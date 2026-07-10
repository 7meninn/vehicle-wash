import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../../../booking/providers/booking_provider.dart';

class MockPaymentScreen extends ConsumerStatefulWidget {
  const MockPaymentScreen({super.key});

  @override
  ConsumerState<MockPaymentScreen> createState() => _MockPaymentScreenState();
}

class _MockPaymentScreenState extends ConsumerState<MockPaymentScreen> {
  bool _isLoading = false;

  Future<void> _handlePaymentSuccess() async {
    setState(() {
      _isLoading = true;
    });
    
    final state = ref.read(bookingProvider);

    try {
      final token = await ref.read(secureStorageProvider).read(key: 'access_token');
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/bookings'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'vehicleId': state.vehicleId,
          'addressId': state.addressId,
          'bookingDate': state.bookingDate ?? '2026-08-12',
          'slotId': state.slotId ?? 's1',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          context.push('/booking/confirmed');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create booking: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.credit_card, size: 80, color: VerdantColors.textSecondary),
              const SizedBox(height: VerdantSpacing.gap * 2),
              Text(
                'Simulate Payment',
                textAlign: TextAlign.center,
                style: VerdantTypography.headlineLarge,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'This is a mock gateway since real payment processing is not yet integrated.',
                textAlign: TextAlign.center,
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding),
              
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                VerdantButton(
                  label: 'Pay Success',
                  onPressed: _handlePaymentSuccess,
                ),
                const SizedBox(height: VerdantSpacing.gap),
                VerdantButton(
                  label: 'Pay Fail',
                  variant: VerdantButtonVariant.secondary,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment Failed. Please try again.')),
                    );
                    context.pop();
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
