import 'dart:math';

Map<String, double> calculateBoundingBox({
  required double latitude,
  required double longitude,
  required double radiusInKm,
}) {
  const double earthRadius = 6371; // Radio de la Tierra en km

  final double latDelta = radiusInKm / earthRadius;
  final double lngDelta = radiusInKm / (earthRadius * cos(pi * latitude / 180));

  return {
    'minLat': latitude - latDelta,
    'maxLat': latitude + latDelta,
    'minLng': longitude - lngDelta,
    'maxLng': longitude + lngDelta,
  };
}
