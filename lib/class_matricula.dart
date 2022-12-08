// To parse this JSON data, do
//
//     final matricula = matriculaFromJson(jsonString);

import 'dart:convert';

Matricula matriculaFromJson(String str) => Matricula.fromJson(json.decode(str));

String matriculaToJson(Matricula data) => json.encode(data.toJson());

class Matricula {
  Matricula({
    this.tipoIdEstudiante,
    this.identificacionEstudiante,
    this.codigocurso,
    this.numerogrupo,
    this.tipomatricula,
    this.nota,
  });

  String? tipoIdEstudiante;
  String? identificacionEstudiante;
  String? codigocurso;
  int? numerogrupo;
  String? tipomatricula;
  int? nota;

  factory Matricula.fromJson(Map<String, dynamic> json) => Matricula(
        tipoIdEstudiante: json["tipo_ID_Estudiante"],
        identificacionEstudiante: json["identificacion_Estudiante"],
        codigocurso: json["codigocurso"],
        numerogrupo: json["numerogrupo"],
        tipomatricula: json["tipomatricula"],
        nota: json["nota"],
      );

  Map<String, dynamic> toJson() => {
        "tipo_ID_Estudiante": tipoIdEstudiante,
        "identificacion_Estudiante": identificacionEstudiante,
        "codigocurso": codigocurso,
        "numerogrupo": numerogrupo,
        "tipomatricula": tipomatricula,
        "nota": nota,
      };
}
