import 'package:flutter/material.dart';

void mostrarAlerta(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Información'),
        content: const Text('Registro Almacenado'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el AlertDialog
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
