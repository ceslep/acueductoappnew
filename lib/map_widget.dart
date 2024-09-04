import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/message_latlong.dart';
import 'package:acueductoapp/random_color_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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

class MapWidget extends StatefulWidget {
  final List<AsoUsuarios> asoUsuarios;

  const MapWidget({super.key, required this.asoUsuarios});

  @override
  State<MapWidget> createState() => _MapWidgetState();
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

class _MapWidgetState extends State<MapWidget> {
  late final List<LocationInfo> coordinates;

  @override
  void initState() {
    super.initState();
    coordinates = widget.asoUsuarios
        .map(
          (e) => LocationInfo(
            coordinates: convertStringToLatLng(e.coordinates!),
            info: '${e.ownerName}',
            info2: '${e.siteType}',
            info3: '${e.siteTarife}',
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> marcadores = coordinates
        .map(
          (c) => Marker(
            point: c.coordinates,
            width: 80,
            height: 80,
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  c.info,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 8,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MessageBoxLatLong(
                              latLong: c.coordinates, // Coordenadas de ejemplo
                              info: c.info,
                              info2: c.info2,
                              info3: c.info3 // Información a mostrar
                              );
                        },
                      );
                    },
                    icon: const RandomColorIcon(size: 40)),
              ],
            ),
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
