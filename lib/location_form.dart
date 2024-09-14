// ignore_for_file: avoid_print

import 'package:acueductoapp/alert_faltan.dart';
import 'package:acueductoapp/alert_guardado.dart';
import 'package:acueductoapp/api/api.asou.dart';
import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/number_persons.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class LocationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const LocationForm({super.key, required this.formKey});

  @override
  State<LocationForm> createState() => LocationFormState();
}

class LocationFormState extends State<LocationForm> {
  Timer? _timer;
  bool obteniendoCoordenadas = false;
  final TextEditingController _coordinatesController = TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _ownerIdController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerTelephoneController =
      TextEditingController();
  final TextEditingController _farmAreaController = TextEditingController();
  final TextEditingController _observationsController = TextEditingController();
  String coordinates = '';
  String siteType = '';
  String siteTarife = '';
  String numberPersons = '';
  String farmName = '';
  String ownerId = '';
  String ownerName = '';
  String ownerTelephone = '';
  String conditione = '';
  String pozo = '';
  String lgbti = '';
  String farmArea = '';
  String observations = '';

  TextEditingController get coordinatesController => _coordinatesController;

  TextEditingController get farmNameController => _farmNameController;
  TextEditingController get ownerIdController => _ownerIdController;
  TextEditingController get ownerNameController => _ownerNameController;
  TextEditingController get ownerTelephoneController =>
      _ownerTelephoneController;
  TextEditingController get farmAreaController => _farmAreaController;
  TextEditingController get observationsController => _observationsController;

  // Método para obtener las coordenadas

  Future<void> _getCurrentLocation() async {
    // Verifica y solicita permisos de ubicación si es necesario
    LocationPermission permission = await Geolocator.checkPermission();
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

    setState(() {
      _coordinatesController.text =
          "Lat.: ${position.latitude}, Long.: ${position.longitude}";
    });
  }

  final List<String> _optionsConditione = [
    '',
    'Indígena',
    'Desplazado',
    'Afrodescendiente',
    'Mestizo',
    'Rural',
    'Urbano',
    'Refugiado',
    'Otro'
  ];

  final List<String> _opcionesPozo = ['', 'Si', 'No', 'En Construcción'];

  final List<String> _opcionesLGBTI = [
    '',
    'No',
    'Bisexual',
    'Gay',
    'Heterosexual',
    'Lesbiana',
    'No binario',
    'Pansexual',
    'Queer',
    'Transgénero',
    'Dos espíritus',
    'Otro'
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      setState(() {});
      if (mounted) {
        _getCurrentLocation().then(
          (value) {
            setState(() {});
          },
        );
        setState(() {
          // Actualiza el estado o ejecuta alguna acción aquí
          // Ejemplo: print('Timer ejecutado cada 500ms');
        });
      }
    });
    _optionsConditione.sort((a, b) => a.compareTo(b));
    _opcionesLGBTI.sort((a, b) => a.compareTo(b));
  }

  @override
  void dispose() {
    // Cancelamos el timer para evitar fugas de memoria
    _timer?.cancel();
    super.dispose();
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
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.purple),
                    foregroundColor:
                        WidgetStateProperty.all(Colors.yellowAccent),
                  ),
                  onPressed: () async {
                    setState(() {
                      obteniendoCoordenadas = true;
                    });
                    await _getCurrentLocation();
                    setState(() {
                      obteniendoCoordenadas = false;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Obtener Coordenadas'),
                      obteniendoCoordenadas
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 239, 216, 243),
                                  strokeWidth: 1,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: siteType,
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
                    siteType = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Tipo de Sitio'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: siteTarife,
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
                  DropdownMenuItem(
                    value: '4',
                    child: Text('Otra'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    siteTarife = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Tipo de tarifa'),
              ),
              TextFormField(
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
                controller: _farmNameController,
                decoration: const InputDecoration(
                    labelText: 'Nombre de la Finca o casa si lo tiene'),
                onChanged: (value) {
                  farmName = value;
                },
              ),
              TextFormField(
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
                controller: _ownerIdController,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                decoration: const InputDecoration(
                    labelText: 'Identificación del Propietario'),
                onChanged: (value) {
                  ownerId = value;
                },
              ),
              TextFormField(
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
                controller: _ownerNameController,
                decoration:
                    const InputDecoration(labelText: 'Nombre del Propietario'),
                onChanged: (value) {
                  ownerName = value;
                },
              ),
              const SizedBox(height: 10),
              NumberPersonsWidget(
                onNumberSelected: (value) {
                  numberPersons = value;
                  print(numberPersons);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
                controller: _ownerTelephoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                onChanged: (value) {
                  ownerTelephone = value;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: conditione,
                items: _optionsConditione.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    conditione = newValue!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Condición'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: pozo,
                items: _opcionesPozo.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    pozo = newValue!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Pozo Pséptico'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: lgbti,
                items: _opcionesLGBTI.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    lgbti = newValue!;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Alguien Condición de Género'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
                controller: _farmAreaController,
                decoration: const InputDecoration(
                    labelText: 'Area de la propiedad en m^2'),
                onChanged: (value) {
                  farmArea = value;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold),
                controller: _observationsController,
                decoration: const InputDecoration(labelText: 'Observaciones'),
                onChanged: (value) {
                  observations = value;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () async {
                    if (widget.formKey.currentState!.validate()) {
                      // Aquí puedes manejar la lógica para guardar el formulario
                      print('Formulario guardado');
                      print('Coordenadas: $coordinates');
                      print('Tipo de Sitio: $siteType');
                      print('Nombre de la Finca: $farmName');
                      print('Identificación del Propietario: $ownerId');
                      print('Nombre del Propietario: $ownerName');
                      print('Teléfono del Propietario: $ownerTelephone');
                      print('Condición: $conditione');
                      print('Pozo Pséptico: $pozo');
                      print('LGBTI: $lgbti');

                      print('Observaciones: $observations');
                      AsoUsuarios asousuario = AsoUsuarios();
                      asousuario.coordinates = coordinatesController.text;
                      asousuario.siteType = siteType;
                      asousuario.siteTarife = siteTarife;
                      asousuario.farmName = farmNameController.text;
                      asousuario.ownerId = ownerIdController.text;
                      asousuario.ownerName = ownerNameController.text;
                      asousuario.numberPersons = numberPersons;
                      asousuario.conditione = conditione;
                      asousuario.ownerTelephone = ownerTelephoneController.text;
                      asousuario.conditione = conditione;
                      asousuario.pozo = pozo;
                      asousuario.lgbti = lgbti;
                      asousuario.farmArea = farmAreaController.text;
                      asousuario.observations = observationsController.text;
                      if (!asousuario.validarCampos()) {
                        mostrarAlertaAlGuardar(context);
                        return;
                      }
                      await guardarUsuario(asousuario);
                      // ignore: use_build_context_synchronously
                      mostrarAlerta(context);
                      coordinatesController.text = '';
                      siteType = '';
                      farmNameController.text = '';
                      _ownerIdController.text = '';
                      _ownerNameController.text = '';
                      numberPersons = '1';
                      _ownerTelephoneController.text = '';
                      siteTarife = '';
                      conditione = '';
                      pozo = '';
                      lgbti = '';
                      _farmAreaController.text = '';
                      observationsController.text = '';
                      setState(() {});
                    }
                  },
                  child: const Text('Guardar Formulario'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
