// To parse this JSON data, do
//
//     final estudiantesGrupos = estudiantesGruposFromJson(jsonString);

import 'dart:convert';

EstudiantesGrupos estudiantesGruposFromJson(String str) =>
    EstudiantesGrupos.fromJson(json.decode(str));

String estudiantesGruposToJson(EstudiantesGrupos data) =>
    json.encode(data.toJson());

class EstudiantesGrupos {
  EstudiantesGrupos({
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
  DateTime? fechaAsistencia;
  String? tipoasistencia;

  factory EstudiantesGrupos.fromJson(Map<String, dynamic> json) =>
      EstudiantesGrupos(
        tipoId: json["tipo_ID"],
        identificacion: json["identificacion"],
        codigocurso: json["codigocurso"],
        numerogrupo: json["numerogrupo"],
        fechaAsistencia: DateTime.parse(json["fechaAsistencia"]),
        tipoasistencia: json["tipoasistencia"],
      );

  Map<String, dynamic> toJson() => {
        "tipo_ID": tipoId,
        "identificacion": identificacion,
        "codigocurso": codigocurso,
        "numerogrupo": numerogrupo,
        "fechaAsistencia": fechaAsistencia?.toIso8601String(),
        "tipoasistencia": tipoasistencia,
      };
}
