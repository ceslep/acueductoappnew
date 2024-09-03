// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:http/http.dart' as http;

String url = "https://app.iedeoccidente.com/";

Future<void> guardarUsuario(AsoUsuarios usuario) async {
  final Uri endPoint = Uri.parse('${url}guardarUsuario.php');
  late final http.Response response;
  final String bodyData =
      json.encode({...usuario.toJson(), "tabla": "dataUsuarios"});
  try {
    response = await http.post(endPoint, body: bodyData);
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final dynamic datos = json.decode(decodedResponse);
      print(datos);
    } else {
      print({"error de response ": response.statusCode});
    }
  } catch (e) {
    print("ha ocurrido un error");
  }
}

Future<List<AsoUsuarios>?> getUsuarios({String criterio = ''}) async {
  final Uri endPoint = Uri.parse('${url}getUsauriosUAC.php');
  late final http.Response response;
  final String bodyData = json.encode({"criterio": criterio});
  try {
    response = criterio == ''
        ? await http.get(endPoint)
        : await http.post(endPoint, body: bodyData);
    if (response.statusCode == 200) {
      List<dynamic> datosUsuarios = json.decode(response.body);
      List<AsoUsuarios> result =
          datosUsuarios.map((p) => AsoUsuarios.fromJson(p)).toList();
      return result;
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al obtener el listado: $e');

    return [];
  }
}
