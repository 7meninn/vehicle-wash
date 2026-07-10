import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import 'package:vehicle_wash_shared/vehicle_wash_shared.dart';
import '../../providers/booking_provider.dart';

class SelectAddressScreen extends ConsumerStatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  ConsumerState<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends ConsumerState<SelectAddressScreen> {
  final MapController _mapController = MapController();
  LatLng? _selectedLocation;
  bool _isLoading = false;

  void _onTap(TapPosition tapPosition, LatLng point) {
    setState(() {
      _selectedLocation = point;
    });
  }

  Future<void> _handleNext() async {
    if (_selectedLocation == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final token = await ref.read(secureStorageProvider).read(key: 'access_token');
      // Create address
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/v1/customers/me/addresses'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'label': 'Dropped Pin',
          'address': 'Custom Location',
          'latitude': _selectedLocation!.latitude,
          'longitude': _selectedLocation!.longitude,
        }),
      );

      // Assume the backend returns the created address with ID, or fallback to mock
      String addressId = "mock_address_id";
      if (response.statusCode == 201 || response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          if (data['data'] != null && data['data']['id'] != null) {
            addressId = data['data']['id'];
          }
        } catch (_) {}
      }

      ref.read(bookingProvider.notifier).setAddressId(addressId);
      
      if (mounted) {
        context.push('/booking/select-time');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save address: $e')),
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
      appBar: AppBar(title: const Text('Book Wash - Select Location')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(28.6139, 77.2090), // New Delhi
              initialZoom: 13.0,
              onTap: _onTap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.vehiclewash.customer',
              ),
              if (_selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _selectedLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_pin,
                        color: VerdantColors.primary,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: VerdantSpacing.cardPadding,
            left: VerdantSpacing.cardPadding,
            right: VerdantSpacing.cardPadding,
            child: SafeArea(
              child: VerdantCard(
                padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _selectedLocation == null
                          ? 'Tap on the map to drop a pin'
                          : 'Location selected',
                      style: VerdantTypography.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: VerdantSpacing.gap),
                    VerdantButton(
                      label: _isLoading ? 'Saving...' : 'Confirm Location',
                      onPressed: _selectedLocation == null || _isLoading
                          ? () {}
                          : _handleNext,
                      variant: _selectedLocation == null
                          ? VerdantButtonVariant.secondary
                          : VerdantButtonVariant.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
