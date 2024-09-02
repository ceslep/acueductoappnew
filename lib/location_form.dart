// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const LocationForm({super.key, required this.formKey});

  @override
  State<LocationForm> createState() => LocationFormState();
}

class LocationFormState extends State<LocationForm> {
  final TextEditingController _coordinatesController = TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _ownerIdController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerTelephoneController =
      TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  String coordinates = '';
  String _siteType = '';
  String _siteTarife = '';
  String _farmName = '';
  String _ownerId = '';
  String _ownerName = '';
  String _ownerTelephone = '';
  String _observations = '';

  TextEditingController get coordinatesController => _coordinatesController;
  String get siteType => _siteType;
  String get siteTarife => _siteTarife;
  TextEditingController get farmNameController => _farmNameController;
  TextEditingController get ownerIdController => _ownerIdController;
  TextEditingController get ownerNameController => _ownerNameController;
  TextEditingController get ownerTelephoneController =>
      _ownerTelephoneController;
  TextEditingController get observationsController => _observationsController;

  // Método para obtener las coordenadas

  Future<void> _getCurrentLocation() async {
    // Verifica y solicita permisos de ubicación si es necesario
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Si los permisos son denegados, muestra un mensaje
        setState(() {
          coordinates = "Permisos de ubicación denegados.";
        });
        return;
      }
    }

    // Obtiene la ubicación actual
    Position position = await Geolocator.getCurrentPosition();

    print(position);

    setState(() {
      _coordinatesController.text =
          "Lat.: ${position.latitude}, Long.: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Coordenadas'),
                controller: _coordinatesController,
                readOnly: true,
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('8');
                    _getCurrentLocation();
                  },
                  child: const Text('Obtener Coordenadas'),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _siteType,
                items: const [
                  DropdownMenuItem(
                    value: '',
                    child: Text(''),
                  ),
                  DropdownMenuItem(
                    value: 'Casa Familiar',
                    child: Text('Casa Familiar'),
                  ),
                  DropdownMenuItem(
                    value: 'Finca',
                    child: Text('Finca'),
                  ),
                  DropdownMenuItem(
                    value: 'Otro',
                    child: Text('Otro'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _siteType = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Tipo de Sitio'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _siteTarife,
                items: const [
                  DropdownMenuItem(
                    value: '',
                    child: Text(''),
                  ),
                  DropdownMenuItem(
                    value: '1',
                    child: Text('Tarifa 1'),
                  ),
                  DropdownMenuItem(
                    value: '2',
                    child: Text('Tarifa 2'),
                  ),
                  DropdownMenuItem(
                    value: '3',
                    child: Text('Tarifa 3'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _siteTarife = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Tipo de tarifa'),
              ),
              TextFormField(
                controller: _farmNameController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de la Finca'),
                onChanged: (value) {
                  _farmName = value;
                },
              ),
              TextFormField(
                controller: _ownerIdController,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                decoration: const InputDecoration(
                    labelText: 'Identificación del Propietario'),
                onChanged: (value) {
                  _ownerId = value;
                },
              ),
              TextFormField(
                controller: _ownerNameController,
                decoration:
                    const InputDecoration(labelText: 'Nombre del Propietario'),
                onChanged: (value) {
                  _ownerName = value;
                },
              ),
              TextFormField(
                controller: _ownerTelephoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                onChanged: (value) {
                  _ownerTelephone = value;
                },
              ),
              TextFormField(
                controller: _observationsController,
                decoration: const InputDecoration(labelText: 'Observaciones'),
                onChanged: (value) {
                  _observations = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    // Aquí puedes manejar la lógica para guardar el formulario
                    print('Formulario guardado');
                    print('Coordenadas: $coordinates');
                    print('Tipo de Sitio: $_siteType');
                    print('Nombre de la Finca: $_farmName');
                    print('Identificación del Propietario: $_ownerId');
                    print('Nombre del Propietario: $_ownerName');
                    print('Nombre del Propietario: $_ownerTelephone');
                    print('Observaciones: $_observations');
                  }
                },
                child: const Text('Guardar Formulario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
