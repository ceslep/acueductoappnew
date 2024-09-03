import 'package:flutter/material.dart';

void mostrarAlertaAlGuardar(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          children: [
            Icon(
              Icons.dangerous,
              color: Colors.red,
            ),
            Text('Alerta'),
          ],
        ),
        content: const Text('Falta Completar la información'),
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
