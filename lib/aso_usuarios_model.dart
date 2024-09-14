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
  String? numberPersons;
  String? ownerTelephone;
  String? pozo;
  String? conditione;
  String? farmArea;
  String? lgbti;
  String? observations;

  AsoUsuarios({
    this.coordinates,
    this.siteType,
    this.siteTarife,
    this.farmName,
    this.ownerId,
    this.ownerName,
    this.numberPersons,
    this.ownerTelephone,
    this.pozo,
    this.conditione,
    this.farmArea,
    this.lgbti,
    this.observations,
  });

  factory AsoUsuarios.fromJson(Map<String, dynamic> json) => AsoUsuarios(
        coordinates: json["coordinates"],
        siteType: json["siteType"],
        siteTarife: json["siteTarife"],
        farmName: json["farmName"],
        ownerId: json["ownerId"],
        ownerName: json["ownerName"],
        numberPersons: json["numberPersons"],
        ownerTelephone: json["ownerTelephone"],
        pozo: json["pozo"],
        conditione: json["conditione"],
        farmArea: json["farmArea"],
        lgbti: json["lgbti"],
        observations: json["observations"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates,
        "siteType": siteType,
        "siteTarife": siteTarife,
        "farmName": farmName,
        "ownerId": ownerId,
        "ownerName": ownerName,
        "numberPersons": numberPersons,
        "ownerTelephone": ownerTelephone,
        "pozo": pozo,
        "conditione": conditione,
        "farmArea": farmArea,
        "lgbti": lgbti,
        "observations": observations,
      };

  void iterarCampos() {
    toJson().forEach((key, value) {
      print('$key: $value');
    });
  }

  bool validarCampos() {
    return coordinates != null &&
        coordinates!.isNotEmpty &&
        coordinates!.length >= 5 &&
        siteType != null &&
        siteType!.isNotEmpty &&
        siteTarife != null &&
        siteTarife!.isNotEmpty &&
        farmName != null &&
        farmName!.isNotEmpty &&
        farmName!.length >= 5 &&
        ownerId != null &&
        ownerId!.isNotEmpty &&
        ownerId!.length >= 5 &&
        ownerName != null &&
        ownerName!.isNotEmpty &&
        ownerName!.length >= 5 &&
        numberPersons != null &&
        numberPersons!.isNotEmpty &&
        ownerTelephone != null &&
        ownerTelephone!.isNotEmpty &&
        ownerTelephone!.length >= 5 &&
        pozo != null &&
        pozo!.isNotEmpty &&
        conditione != null &&
        conditione!.isNotEmpty &&
        farmArea != null &&
        farmArea!.isNotEmpty &&
        lgbti != null &&
        lgbti!.isNotEmpty;
  }
}
