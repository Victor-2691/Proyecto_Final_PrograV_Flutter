// To parse this JSON data, do
//
//     final grupos = gruposFromJson(jsonString);

import 'dart:convert';

List<Grupos> gruposFromJson(String str) =>
    List<Grupos>.from(json.decode(str).map((x) => Grupos.fromJson(x)));

String gruposToJson(List<Grupos> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Grupos {
  Grupos({
    required this.numeroGrupo,
    required this.horario,
    required this.anno,
    required this.numeroPeriodo,
    required this.nombre,
    required this.primerApellido,
    required this.segundoApellido,
  });

  int numeroGrupo;
  String horario;
  int anno;
  int numeroPeriodo;
  String nombre;
  String primerApellido;
  String segundoApellido;

  factory Grupos.fromJson(Map<String, dynamic> json) => Grupos(
        numeroGrupo: json["numero_Grupo"],
        horario: json["horario"],
        anno: json["anno"],
        numeroPeriodo: json["numeroPeriodo"],
        nombre: json["nombre"],
        primerApellido: json["primer_Apellido"],
        segundoApellido: json["segundo_apellido"],
      );

  Map<String, dynamic> toJson() => {
        "numero_Grupo": numeroGrupo,
        "horario": horario,
        "anno": anno,
        "numeroPeriodo": numeroPeriodo,
        "nombre": nombre,
        "primer_Apellido": primerApellido,
        "segundo_apellido": segundoApellido,
      };
}
