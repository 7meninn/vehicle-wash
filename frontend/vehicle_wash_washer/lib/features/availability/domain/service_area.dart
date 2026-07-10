import 'package:latlong2/latlong.dart';

class ServiceArea {
  final String id;
  final String name;
  final List<LatLng> polygon;

  ServiceArea({
    required this.id,
    required this.name,
    required this.polygon,
  });

  factory ServiceArea.fromJson(Map<String, dynamic> json) {
    return ServiceArea(
      id: json['id'] as String,
      name: json['name'] as String,
      polygon: (json['polygon'] as List)
          .map((point) => LatLng(point['lat'] as double, point['lng'] as double))
          .toList(),
    );
  }
}
