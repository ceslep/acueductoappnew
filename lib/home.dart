// ignore_for_file: avoid_print

import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/location_form.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AsoUsuarios asousuario = AsoUsuarios();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<LocationFormState> _locationFormKey =
      GlobalKey<LocationFormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Acueducto el Porvenir',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Acceder al valor del farmNameController
                final farmName =
                    _locationFormKey.currentState?.farmNameController.text;
                asousuario.farmName = farmName;
                print(asousuario.farmName);
              }
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: LocationForm(formKey: _formKey, key: _locationFormKey),
    );
  }
}
