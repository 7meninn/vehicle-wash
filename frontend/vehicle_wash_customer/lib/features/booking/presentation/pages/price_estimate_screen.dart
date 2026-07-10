import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../../providers/booking_provider.dart';

class PriceEstimateScreen extends ConsumerStatefulWidget {
  const PriceEstimateScreen({super.key});

  @override
  ConsumerState<PriceEstimateScreen> createState() => _PriceEstimateScreenState();
}

class _PriceEstimateScreenState extends ConsumerState<PriceEstimateScreen> {
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _priceEstimate;

  @override
  void initState() {
    super.initState();
    _fetchPrice();
  }

  Future<void> _fetchPrice() async {
    final state = ref.read(bookingProvider);
    try {
      final token = await ref.read(secureStorageProvider).read(key: 'access_token');
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/bookings/calculate-price'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'vehicleId': state.vehicleId,
          'addressId': state.addressId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setState(() {
          _priceEstimate = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to calculate price.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review & Confirm')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Price Estimate',
                style: VerdantTypography.headlineMedium,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Review the charges before finalizing your booking.',
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.sectionPadding / 2),
              
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_error != null)
                Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              else
                VerdantCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildRow('Base Wash Price', '₹${_priceEstimate?['basePrice'] ?? 0}'),
                      const SizedBox(height: VerdantSpacing.gap),
                      _buildRow('Travel Charge', '₹${_priceEstimate?['travelCharge'] ?? 0}'),
                      const SizedBox(height: VerdantSpacing.gap),
                      _buildRow('Distance', '${_priceEstimate?['distanceKm'] ?? 0} km'),
                      const SizedBox(height: VerdantSpacing.gap),
                      _buildRow('GST (18%)', '₹${_priceEstimate?['gst'] ?? 0}'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: VerdantSpacing.gap),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: VerdantTypography.titleLarge),
                          Text(
                            '₹${_priceEstimate?['totalPrice'] ?? 0}',
                            style: VerdantTypography.headlineLarge.copyWith(color: VerdantColors.warmSand),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              
              const Spacer(),
              VerdantButton(
                label: 'Confirm Booking',
                onPressed: _isLoading || _error != null
                    ? () {}
                    : () {
                        context.push('/payment/mock');
                      },
                variant: _isLoading || _error != null
                    ? VerdantButtonVariant.secondary
                    : VerdantButtonVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: VerdantTypography.bodyLarge),
        Text(amount, style: VerdantTypography.titleMedium),
      ],
    );
  }
}
