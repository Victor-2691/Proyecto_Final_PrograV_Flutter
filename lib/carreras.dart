// To parse this JSON data, do
//
//     final carreras = carrerasFromJson(jsonString);

import 'dart:convert';

List<Carreras> carrerasFromJson(String str) =>
    List<Carreras>.from(json.decode(str).map((x) => Carreras.fromJson(x)));

String carrerasToJson(List<Carreras> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carreras {
  Carreras({
    required this.codigoCarrera,
    required this.nombreCarrera,
  });

  String codigoCarrera;
  String nombreCarrera;

  factory Carreras.fromJson(Map<String, dynamic> json) => Carreras(
        codigoCarrera: json["codigo_Carrera"],
        nombreCarrera: json["nombre_Carrera"],
      );

  Map<String, dynamic> toJson() => {
        "codigo_Carrera": codigoCarrera,
        "nombre_Carrera": nombreCarrera,
      };
}
