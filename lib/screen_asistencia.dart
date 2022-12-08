import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_final_prograv/class_asistencia.dart';
import 'package:http/http.dart' as http;

class screen_matricula extends StatefulWidget {
  final String tipoId;
  final String id;
  final int numerogrupo;
  final String codigocurs;
  const screen_matricula(
      this.tipoId, this.id, this.numerogrupo, this.codigocurs,
      {super.key});

  @override
  State<screen_matricula> createState() => _screen_matriculaState();
}

class _screen_matriculaState extends State<screen_matricula> {
  late DateTime birthdate;
  String gender = "Sexo";
  final _formKey = GlobalKey<FormState>();

  String? seleccionado;
  List Listavalores = [
    "Ausencia",
    "Ausencia Justificada",
    "Ausencia Injustificada"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asistencia"),
      ),
      body: Center(
        child: DropdownButton(
          hint: Text("seleccione el tipo de asistencia"),
          value: seleccionado,
          onChanged: (newvalue) {
            setState(() {
              seleccionado = newvalue as String?;
            });
          },
          items: Listavalores.map((valueItem) {
            return DropdownMenuItem(
              value: valueItem,
              child: Text(valueItem),
            );
          }).toList(),
        ),
      ),
    );
  }

  static Future<String> postAsistencia(Asistencia c) async {
    var url = Uri.parse(
        'http://apisprogravfinal.somee.com/api/Asistencias/CrearAsistencia');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(c.toJson()));
    if (response.statusCode == 201) {
      return "201";
    }
    if (response.statusCode == 409) {
      return "404";
    }
    if (response.statusCode == 500) {
      return "error de servidor";
    }
    return "";
  }
}
