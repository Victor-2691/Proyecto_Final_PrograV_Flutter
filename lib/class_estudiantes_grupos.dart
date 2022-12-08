// To parse this JSON data, do
//
//     final estudiantesGrupos = estudiantesGruposFromJson(jsonString);

import 'dart:convert';

List<EstudiantesGrupos> estudiantesGruposFromJson(String str) =>
    List<EstudiantesGrupos>.from(
        json.decode(str).map((x) => EstudiantesGrupos.fromJson(x)));

String estudiantesGruposToJson(List<EstudiantesGrupos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EstudiantesGrupos {
  EstudiantesGrupos({
    required this.nombreCurso,
    required this.nombreCarrera,
    required this.numeroGrupo,
    required this.codigoCurso,
  });

  String nombreCurso;
  String nombreCarrera;
  int numeroGrupo;
  String codigoCurso;

  factory EstudiantesGrupos.fromJson(Map<String, dynamic> json) =>
      EstudiantesGrupos(
        nombreCurso: json["nombre_Curso"],
        nombreCarrera: json["nombre_Carrera"],
        numeroGrupo: json["numero_Grupo"],
        codigoCurso: json["codigo_Curso"],
      );

  Map<String, dynamic> toJson() => {
        "nombre_Curso": nombreCurso,
        "nombre_Carrera": nombreCarrera,
        "numero_Grupo": numeroGrupo,
        "codigo_Curso": codigoCurso,
      };
}
