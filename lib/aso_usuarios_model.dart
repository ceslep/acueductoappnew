// To parse this JSON data, do
//
//     final asoUsuarios = asoUsuariosFromJson(jsonString);

// ignore_for_file: avoid_print

import 'dart:convert';

AsoUsuarios asoUsuariosFromJson(String str) =>
    AsoUsuarios.fromJson(json.decode(str));

String asoUsuariosToJson(AsoUsuarios data) => json.encode(data.toJson());

class AsoUsuarios {
  String? coordinates;
  String? siteType;
  String? siteTarife;
  String? farmName;
  String? ownerId;
  String? ownerName;
  String? ownerTelephone;
  String? observations;

  AsoUsuarios({
    this.coordinates,
    this.siteType,
    this.siteTarife,
    this.farmName,
    this.ownerId,
    this.ownerName,
    this.ownerTelephone,
    this.observations,
  });

  factory AsoUsuarios.fromJson(Map<String, dynamic> json) => AsoUsuarios(
        coordinates: json["coordinates"],
        siteType: json["siteType"],
        siteTarife: json["siteTarife"],
        farmName: json["farmName"],
        ownerId: json["ownerId"],
        ownerName: json["ownerName"],
        ownerTelephone: json["ownerTelephone"],
        observations: json["observations"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates,
        "siteType": siteType,
        "siteTarife": siteTarife,
        "farmName": farmName,
        "ownerId": ownerId,
        "ownerName": ownerName,
        "ownerTelephone": ownerTelephone,
        "observations": observations,
      };

  void iterarCampos() {
    toJson().forEach((key, value) {
      print('$key: $value');
    });
  }
}
