import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/map_widget_user.dart';
import 'package:flutter/material.dart';

class ViewMapUser extends StatefulWidget {
  final AsoUsuarios asoUsuario;
  const ViewMapUser({super.key, required this.asoUsuario});

  @override
  State<ViewMapUser> createState() => _MapViewState();
}

class _MapViewState extends State<ViewMapUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 22, 150),
        title: const Text(
          'Mapa de Usuario',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: MapWidgetUser(
        asoUsuario: widget.asoUsuario,
      ),
    );
  }
}
