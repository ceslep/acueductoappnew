import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/map_widget.dart';
import 'package:acueductoapp/map_widget_heat.dart';
import 'package:flutter/material.dart';

class VerMap extends StatefulWidget {
  final List<AsoUsuarios> asoUsuarios;
  const VerMap({super.key, required this.asoUsuarios});

  @override
  State<VerMap> createState() => _MapViewState();
}

class _MapViewState extends State<VerMap> {
  bool heat = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  heat = !heat;
                });
              },
              icon: Icon(
                !heat ? Icons.heat_pump : Icons.map_rounded,
                color: !heat ? Colors.white : Colors.yellow,
              ),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 58, 121, 0),
        title: const Text(
          'Mapa de Usuarios',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: !heat
          ? MapWidget(
              asoUsuarios: widget.asoUsuarios,
            )
          : MapWidgetHeat(asoUsuarios: widget.asoUsuarios),
    );
  }
}
