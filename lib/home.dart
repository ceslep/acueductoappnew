// ignore_for_file: avoid_print

import 'dart:collection';

import 'package:acueductoapp/api/api.asou.dart';
import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/location_form.dart';
import 'package:acueductoapp/map_view.dart';
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VerMap()),
              );
            },
            icon: const Icon(Icons.map),
          ),
          IconButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Acceder al valor del farmNameController
                final state = _locationFormKey.currentState!;
                asousuario.coordinates = state.coordinatesController.text;
                asousuario.siteType = state.siteType;
                asousuario.siteTarife = state.siteTarife;
                asousuario.farmName = state.farmNameController.text;
                asousuario.ownerId = state.ownerIdController.text;
                asousuario.ownerName = state.ownerNameController.text;
                asousuario.ownerTelephone = state.ownerTelephoneController.text;
                asousuario.observations = state.observationsController.text;
                await guardarUsuario(asousuario);
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
