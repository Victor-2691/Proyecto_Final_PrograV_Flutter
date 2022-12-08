import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_final_prograv/class_cursos.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final_prograv/screen_grupos.dart';

class screen_curso extends StatefulWidget {
  final String tipoid;
  final String id;
  final String codigocarre;
  const screen_curso(this.tipoid, this.id, this.codigocarre, {super.key});

  @override
  State<screen_curso> createState() => _screen_cursoState();
}

class _screen_cursoState extends State<screen_curso> {
  List<Cursos> data = <Cursos>[];

  void initState() {
    super.initState();
    getCursos(widget.codigocarre).then((value) {
      setState(() {
        data.addAll(value!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Cursos")),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                //Con la propiedad onTap agregamos funcioanlidad al trailing que es la fecla que se muestra al final
                onTap: () {
                  //Enviar datos del estudiante - codigoCurso
                  String codigoCurso = data[index].codigoCurso;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => grupos_screen(
                              widget.tipoid, widget.id, codigoCurso))));
                },
                title: Text(data[index].nombreCurso),
                subtitle: Text(data[index].codigoCurso),
                leading: CircleAvatar(
                    child: Text(data[index].nombreCurso.substring(0, 1))),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              );
            }));
  }

  //Api Consulta Cursos por carrera
  static Future<List<Cursos>?> getCursos(String idcarrera) async {
    var url = Uri.parse(
        'http://apisprogravfinal.somee.com/api/Cursoes/CursosPorCarrera?CodigoCarrera=' +
            idcarrera);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Cursos> carreras =
          List<Cursos>.from(l.map((model) => Cursos.fromJson(model)));
      return carreras;
    } else {
      return null;
    }
  }
}
