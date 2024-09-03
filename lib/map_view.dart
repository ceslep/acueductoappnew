import 'package:acueductoapp/map_widget.dart';
import 'package:flutter/material.dart';

class VerMap extends StatefulWidget {
  const VerMap({super.key});

  @override
  State<VerMap> createState() => _MapViewState();
}

class _MapViewState extends State<VerMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Usuarios'),
      ),
      body: const MapWidget(),
    );
  }
}
