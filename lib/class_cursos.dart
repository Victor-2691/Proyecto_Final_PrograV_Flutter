// To parse this JSON data, do
//
//     final cursos = cursosFromJson(jsonString);

import 'dart:convert';

List<Cursos> cursosFromJson(String str) =>
    List<Cursos>.from(json.decode(str).map((x) => Cursos.fromJson(x)));

String cursosToJson(List<Cursos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cursos {
  Cursos({
    required this.codigoCarrera,
    required this.nombreCarrera,
    required this.codigoCurso,
    required this.nombreCurso,
  });

  String codigoCarrera;
  String nombreCarrera;
  String codigoCurso;
  String nombreCurso;

  factory Cursos.fromJson(Map<String, dynamic> json) => Cursos(
        codigoCarrera: json["codigo_Carrera"],
        nombreCarrera: json["nombre_Carrera"],
        codigoCurso: json["codigo_Curso"],
        nombreCurso: json["nombre_Curso"],
      );

  Map<String, dynamic> toJson() => {
        "codigo_Carrera": codigoCarrera,
        "nombre_Carrera": nombreCarrera,
        "codigo_Curso": codigoCurso,
        "nombre_Curso": nombreCurso,
      };
}
