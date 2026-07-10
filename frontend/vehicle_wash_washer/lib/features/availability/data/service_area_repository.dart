import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../domain/service_area.dart';

class ServiceAreaRepository {
  final http.Client _client;
  final String baseUrl = 'http://localhost:8080/api/v1';

  ServiceAreaRepository(this._client);

  // MOCK: Fetch all predefined service areas
  Future<List<ServiceArea>> getAllServiceAreas() async {
    // In a real app, this would be an API call like GET /api/v1/service-areas
    // We mock the response with some polygons for testing.
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ServiceArea(
        id: 'area_1',
        name: 'Downtown',
        polygon: [
          const LatLng(28.61, 77.20),
          const LatLng(28.62, 77.20),
          const LatLng(28.62, 77.22),
          const LatLng(28.61, 77.22),
        ],
      ),
      ServiceArea(
        id: 'area_2',
        name: 'South Extension',
        polygon: [
          const LatLng(28.56, 77.21),
          const LatLng(28.57, 77.21),
          const LatLng(28.57, 77.23),
          const LatLng(28.56, 77.23),
        ],
      ),
      ServiceArea(
        id: 'area_3',
        name: 'Vasant Kunj',
        polygon: [
          const LatLng(28.53, 77.15),
          const LatLng(28.54, 77.15),
          const LatLng(28.54, 77.17),
          const LatLng(28.53, 77.17),
        ],
      ),
    ];
  }

  // API Call: Update Washer's Service Areas
  Future<void> updateServiceAreas(List<String> serviceAreaIds) async {
    // NOTE: Auth token injection usually handled by a centralized interceptor. 
    // We assume the token is handled elsewhere, or we just pass the request.
    final url = Uri.parse('$baseUrl/washers/me/service-areas');
    final response = await _client.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'serviceAreaIds': serviceAreaIds,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      // Typically throw an exception or handle error
      throw Exception('Failed to update service areas');
    }
  }

  // API Call: Get Washer's Current Service Areas
  Future<List<String>> getMyServiceAreaIds() async {
    final url = Uri.parse('$baseUrl/washers/me/service-areas');
    try {
      final response = await _client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['serviceAreaIds'] != null) {
          return List<String>.from(data['data']['serviceAreaIds']);
        }
      }
    } catch (e) {
      // Ignoring errors for mock purposes
    }
    // Mock default
    return ['area_1'];
  }
}
