import 'package:flutter/material.dart';

class NumberPersonsWidget extends StatefulWidget {
  final Function(String)
      onNumberSelected; // Función que recibirá el valor seleccionado

  const NumberPersonsWidget({super.key, required this.onNumberSelected});

  @override
  State<NumberPersonsWidget> createState() => _NumberPersonsWidgetState();
}

class _NumberPersonsWidgetState extends State<NumberPersonsWidget> {
  List<int> numbers =
      List<int>.generate(15, (index) => index + 1); // Genera el array [0..9]
  String numberPersons = "1"; // Valor inicial de la variable String

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField<String>(
          value: numberPersons, // El valor seleccionado actualmente
          onChanged: (String? newValue) {
            setState(() {
              numberPersons =
                  newValue!; // Actualizamos la variable con el nuevo valor
            });
            widget.onNumberSelected(
                numberPersons); // Llamamos al callback para pasar el valor al padre
          },
          items: numbers.map<DropdownMenuItem<String>>((int value) {
            return DropdownMenuItem<String>(
              value: (value).toString(), // Convertimos el valor a String
              child: Text((value).toString()), // Mostramos el valor como String
            );
          }).toList(),
          decoration: const InputDecoration(labelText: 'Número de Personas'),
        ),
      ],
    );
  }
}
