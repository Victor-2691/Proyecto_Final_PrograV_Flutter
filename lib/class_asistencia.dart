// To parse this JSON data, do
//
//     final asistencia = asistenciaFromJson(jsonString);

import 'dart:convert';

Asistencia asistenciaFromJson(String str) =>
    Asistencia.fromJson(json.decode(str));

String asistenciaToJson(Asistencia data) => json.encode(data.toJson());

class Asistencia {
  Asistencia({
    this.tipoId,
    this.identificacion,
    this.codigocurso,
    this.numerogrupo,
    this.fechaAsistencia,
    this.tipoasistencia,
  });

  String? tipoId;
  String? identificacion;
  String? codigocurso;
  int? numerogrupo;
  String? fechaAsistencia;
  String? tipoasistencia;

  factory Asistencia.fromJson(Map<String, dynamic> json) => Asistencia(
        tipoId: json["tipo_ID"],
        identificacion: json["identificacion"],
        codigocurso: json["codigocurso"],
        numerogrupo: json["numerogrupo"],
        fechaAsistencia: (json["fechaAsistencia"]),
        tipoasistencia: json["tipoasistencia"],
      );

  Map<String, dynamic> toJson() => {
        "tipo_ID": tipoId,
        "identificacion": identificacion,
        "codigocurso": codigocurso,
        "numerogrupo": numerogrupo,
        "fechaAsistencia": fechaAsistencia,
        "tipoasistencia": tipoasistencia,
      };
}
