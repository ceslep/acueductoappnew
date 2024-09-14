import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:latlong2/latlong.dart';

class LocationInfo {
  LatLng coordinates;
  String info;
  String info2;
  String info3;

  LocationInfo({
    required this.coordinates,
    required this.info,
    required this.info2,
    required this.info3,
  });

  // Método para obtener una representación en cadena de la instancia
  @override
  String toString() {
    return 'Coordinates: (${coordinates.latitude}, ${coordinates.longitude}), Info: $info, Info2: $info2';
  }
}

class MapWidgetHeat extends StatefulWidget {
  final List<AsoUsuarios> asoUsuarios;

  const MapWidgetHeat({super.key, required this.asoUsuarios});

  @override
  State<MapWidgetHeat> createState() => _MapWidgetHeatState();
}

LatLng convertStringToLatLng(String coordinates) {
  // Remueve "Lat.:" y "Long.:" y divide el string por la coma
  List<String> parts =
      coordinates.replaceAll('Lat.: ', '').replaceAll('Long.: ', '').split(',');

  // Convierte las partes en números de tipo double
  double latitude = double.parse(parts[0].trim());
  double longitude = double.parse(parts[1].trim());

  // Retorna un objeto LatLng
  return LatLng(latitude, longitude);
}

class _MapWidgetHeatState extends State<MapWidgetHeat> {
  late final List<LocationInfo> coordinates;
  late final List<WeightedLatLng> data;
  List<Map<double, MaterialColor>> gradients = [
    HeatMapOptions.defaultGradient,
    {0.25: Colors.blue, 0.55: Colors.red, 0.85: Colors.pink, 1.0: Colors.purple}
  ];

  @override
  void initState() {
    super.initState();
    data = widget.asoUsuarios
        .map((e) {
          LatLng coordenadas = convertStringToLatLng(e.coordinates!);
          return coordenadas;
        })
        .map(
          (e) => WeightedLatLng(e, 10),
        )
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(5.31375, -75.80404), // Center the map over London
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          // Display map tiles from any source
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
          userAgentPackageName: 'com.example.app',
          maxNativeZoom:
              15, // Scale tiles when the server doesn't support higher zoom levels
          // And many more recommended properties!
        ),
        HeatMapLayer(
          heatMapDataSource: InMemoryHeatMapDataSource(data: data),
          heatMapOptions:
              HeatMapOptions(gradient: gradients[1], minOpacity: 0.7),
        ),
      ],
    );
  }
}
