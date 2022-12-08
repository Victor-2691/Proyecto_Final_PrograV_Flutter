import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto_final_prograv/class_matricula.dart';

class matricula_service {
  static Future<String> postmatricula(Matricula c) async {
    var url = Uri.parse(
        'http://apisprogravfinal.somee.com/api/Matriculas/CrearMatricula');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(c.toJson()));
    if (response.statusCode == 201) {
      return "201";
    }
    if (response.statusCode == 409) {
      return "409";
    }
    if (response.statusCode == 500) {
      return "error de servidor";
    }
    return "";
  }
}
