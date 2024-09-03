import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/map_widget.dart';
import 'package:flutter/material.dart';

class VerMap extends StatefulWidget {
  final List<AsoUsuarios> asoUsuarios;
  const VerMap({super.key, required this.asoUsuarios});

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
      body: MapWidget(
        asoUsuarios: widget.asoUsuarios,
      ),
    );
  }
}
