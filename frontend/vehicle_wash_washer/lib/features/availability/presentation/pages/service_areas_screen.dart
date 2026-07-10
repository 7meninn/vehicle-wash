import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';
import '../../providers/service_area_provider.dart';

class ServiceAreasScreen extends ConsumerStatefulWidget {
  const ServiceAreasScreen({super.key});

  @override
  ConsumerState<ServiceAreasScreen> createState() => _ServiceAreasScreenState();
}

class _ServiceAreasScreenState extends ConsumerState<ServiceAreasScreen> {
  final MapController _mapController = MapController();
  bool _isSaving = false;

  Future<void> _handleSave() async {
    setState(() {
      _isSaving = true;
    });
    try {
      await ref.read(selectedServiceAreasProvider.notifier).saveSelections();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Service areas updated successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update service areas: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final allAreasAsync = ref.watch(allServiceAreasProvider);
    final selectedAreasAsync = ref.watch(selectedServiceAreasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Areas'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: allAreasAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (allAreas) {
            final selectedIds = selectedAreasAsync.value ?? [];
            
            final polygons = allAreas.map((area) {
              final isSelected = selectedIds.contains(area.id);
              return Polygon(
                points: area.polygon,
                color: isSelected 
                    ? VerdantColors.primary.withValues(alpha: 0.5) 
                    : VerdantColors.surfaceElevated.withValues(alpha: 0.5),
                borderColor: isSelected 
                    ? VerdantColors.primary 
                    : VerdantColors.border,
                borderStrokeWidth: 2,
              );
            }).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Service Areas',
                        style: VerdantTypography.headlineMedium,
                      ),
                      const SizedBox(height: VerdantSpacing.base),
                      Text(
                        'Tap on the areas on the map you are willing to travel to for wash appointments.',
                        style: VerdantTypography.bodyLarge,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: const LatLng(28.61, 77.20),
                      initialZoom: 11.0,
                      onTap: (tapPosition, point) {
                        // Very simple bounding box check for polygon tap since true point-in-polygon
                        // can be complex. In a real app you'd use a geospatial library.
                        for (final area in allAreas) {
                          if (_isPointInPolygon(point, area.polygon)) {
                            ref.read(selectedServiceAreasProvider.notifier).toggleSelection(area.id);
                            break;
                          }
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.verdant.washer',
                      ),
                      PolygonLayer(
                        polygons: polygons,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
                  child: VerdantButton(
                    onPressed: _isSaving ? () {} : () { _handleSave(); },
                    label: _isSaving ? 'Saving...' : 'Save Service Areas',
                    variant: VerdantButtonVariant.primary,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Ray-casting algorithm to determine if a point is inside a polygon
  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    bool isInside = false;
    for (int i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
      if (((polygon[i].longitude > point.longitude) != (polygon[j].longitude > point.longitude)) &&
          (point.latitude < (polygon[j].latitude - polygon[i].latitude) * 
          (point.longitude - polygon[i].longitude) / 
          (polygon[j].longitude - polygon[i].longitude) + polygon[i].latitude)) {
        isInside = !isInside;
      }
    }
    return isInside;
  }
}
