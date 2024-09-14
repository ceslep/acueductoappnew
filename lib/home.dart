// ignore_for_file: avoid_print

import 'dart:io';

import 'package:acueductoapp/alert_faltan.dart';
import 'package:acueductoapp/alert_guardado.dart';
import 'package:acueductoapp/api/api.asou.dart';
import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/listado_usuarios.dart';
import 'package:acueductoapp/location_form.dart';
import 'package:acueductoapp/map_view.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool cargandoUsuarios = false;
  bool cargandoUsuariosMapa = false;
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
                final state = _locationFormKey.currentState!;

                state.coordinatesController.text = '';
                state.siteType = '';
                state.siteTarife = '';
                state.farmNameController.text = '';
                state.ownerIdController.text = '';
                state.ownerNameController.text = '';
                state.numberPersons = '1';
                state.ownerTelephoneController.text = '';
                state.conditione = '';
                state.pozo = '';
                state.lgbti = '';
                state.farmAreaController.text = '';
                state.observationsController.text = '';
              }
            },
            icon: const Icon(
              Icons.new_label_outlined,
              color: Colors.white,
            ),
          ),
          !cargandoUsuarios
              ? IconButton(
                  onPressed: () async {
                    setState(() {
                      cargandoUsuarios = true;
                    });
                    List<AsoUsuarios>? asoUsuarios = await getUsuarios();
                    setState(() {
                      cargandoUsuarios = false;
                    });
                    if (mounted) {
                      // Verifica si el widget sigue montado
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListadoUsuarios(
                            asoUsuarios: asoUsuarios!,
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.list_alt,
                    color: Colors.white,
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  ),
                ),
          !cargandoUsuariosMapa
              ? IconButton(
                  onPressed: () async {
                    setState(() {
                      cargandoUsuariosMapa = true;
                    });
                    List<AsoUsuarios>? asoUsuarios = await getUsuarios();
                    setState(() {
                      cargandoUsuariosMapa = false;
                    });
                    if (mounted) {
                      // Verifica si el widget sigue montado
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerMap(
                                  asoUsuarios: asoUsuarios!,
                                )),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  ),
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
                asousuario.numberPersons = state.numberPersons;
                asousuario.ownerTelephone = state.ownerTelephoneController.text;
                asousuario.conditione = state.conditione;
                asousuario.pozo = state.pozo;
                asousuario.lgbti = state.lgbti;
                asousuario.farmArea = state.farmAreaController.text;
                asousuario.observations = state.observationsController.text;
                if (!asousuario.validarCampos()) {
                  mostrarAlertaAlGuardar(context);
                  return;
                }
                await guardarUsuario(asousuario);
                // ignore: use_build_context_synchronously
                mostrarAlerta(context);
                state.coordinatesController.text = '';
                state.siteType = '';
                state.siteTarife = '';
                state.farmNameController.text = '';
                state.ownerIdController.text = '';
                state.ownerNameController.text = '';
                state.numberPersons = '1';
                state.ownerTelephoneController.text = '';
                state.conditione = '';
                state.pozo = '';
                state.lgbti = '';
                state.farmAreaController.text = '';
                state.observationsController.text = '';
              }
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              exit(0);
            },
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
