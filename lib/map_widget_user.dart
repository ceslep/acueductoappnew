import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/message_latlong.dart';
import 'package:acueductoapp/random_color_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationInfoUser {
  LatLng coordinates;
  String info;
  String info2;
  String info3;

  LocationInfoUser({
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

class MapWidgetUser extends StatefulWidget {
  final AsoUsuarios asoUsuario;

  const MapWidgetUser({super.key, required this.asoUsuario});

  @override
  State<MapWidgetUser> createState() => _MapWidgetUserState();
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

class _MapWidgetUserState extends State<MapWidgetUser> {
  late final LocationInfoUser coordinate;

  @override
  void initState() {
    super.initState();
    final e = widget.asoUsuario;
    coordinate = LocationInfoUser(
      coordinates: convertStringToLatLng(e.coordinates!),
      info: '${e.ownerName}',
      info2: '${e.siteType}',
      info3: '${e.siteTarife}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = coordinate;
    final Marker marcador = Marker(
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
              icon: const RandomColorIcon(
                size: 35,
              )),
        ],
      ),
    );

    return FlutterMap(
      options: MapOptions(
        initialCenter: c.coordinates, // Center the map over London
        initialZoom: 20,
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
        MarkerLayer(markers: [marcador])
      ],
    );
  }
}
