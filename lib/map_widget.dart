import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final List<LatLng> coordinates = const [
    LatLng(5.31431, -75.80573),
    LatLng(5.31369, -75.80405),
    LatLng(5.31439, -75.80647),
    // Agrega más coordenadas aquí
  ];

  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Marker> marcadores = coordinates
        .map(
          (c) => Marker(
            point: c,
            width: 80,
            height: 80,
            child: const Icon(Icons.cookie),
          ),
        )
        .toList();

    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(5.31375, -75.80404), // Center the map over London
        initialZoom: 16,
      ),
      children: [
        TileLayer(
          // Display map tiles from any source
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
          userAgentPackageName: 'com.example.app',
          maxNativeZoom:
              19, // Scale tiles when the server doesn't support higher zoom levels
          // And many more recommended properties!
        ),
        MarkerLayer(markers: marcadores)
      ],
    );
  }
}
