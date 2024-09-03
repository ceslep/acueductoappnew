import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MessageBoxLatLong extends StatefulWidget {
  final LatLng latLong;
  final String info;
  final String info2;
  final String info3;

  const MessageBoxLatLong(
      {super.key,
      required this.latLong,
      required this.info,
      required this.info2,
      required this.info3});

  @override
  State<MessageBoxLatLong> createState() => _MessageBoxLatLongState();
}

class _MessageBoxLatLongState extends State<MessageBoxLatLong> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Información de Ubicación'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Coordenadas:'),
          Text('Latitud: ${widget.latLong.latitude}'),
          Text('Longitud: ${widget.latLong.longitude}'),
          const SizedBox(height: 10),
          const Text(
            'Usuario:',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.info),
          const Text(
            "Tipo de Lugar:",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.info2),
          const Text(
            "Tipo de tarifa:",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.info3),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
