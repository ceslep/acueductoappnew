import 'dart:math';
import 'package:flutter/material.dart';

class RandomColorIcon extends StatelessWidget {
  final double size;

  // Constructor con parámetro opcional 'size'
  const RandomColorIcon({super.key, this.size = 10}); // Valor por defecto de 10

  // Función para generar un color aleatorio
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.place,
      color: getRandomColor(), // Color aleatorio
      size: size, // Tamaño con valor por defecto o personalizado
    );
  }
}
