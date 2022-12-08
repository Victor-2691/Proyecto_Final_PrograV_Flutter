import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final_prograv/class_asistencia.dart';
import 'package:proyecto_final_prograv/class_service_matricula.dart';
import 'package:proyecto_final_prograv/screen_asistencia.dart';

import 'class_estudiantes_grupos.dart';
import 'class_matricula.dart';

class screen_est_grupos extends StatefulWidget {
  final String tipoId;
  final String id;

  const screen_est_grupos(this.tipoId, this.id, {super.key});

  @override
  State<screen_est_grupos> createState() => _screen_est_gruposState();
}

class _screen_est_gruposState extends State<screen_est_grupos> {
  List<EstudiantesGrupos> data = <EstudiantesGrupos>[];

  void initState() {
    super.initState();

    getCursos_Estudiante(widget.id + "-" + widget.tipoId).then((value) {
      setState(() {
        data.addAll(value!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Grupos Estudiante ID : " + widget.id)),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                //Con la propiedad onTap agregamos funcioanlidad al trailing que es la fecla que se muestra al final
                onLongPress: () {
                  _consulasistencia(context, data[index].codigoCurso,
                      data[index].numeroGrupo);
                  //Enviar datos del estudiante - codigocurso - numero grupo

                  //Por ejemplo capturar los datos como el codigo de la carrera y pasarlo a otra pantalla
                  //Codigo cuando da click a algun elemento
                  //con el onLongPress funciona dejando presionado el control
                },
                title: Text(data[index].nombreCurso +
                    " - " +
                    " Grupo: " +
                    data[index].numeroGrupo.toString()),
                subtitle: Text(data[index].nombreCarrera),
                leading: CircleAvatar(
                    child: Text(data[index].nombreCurso.substring(0, 1))),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              );
            }));
  }

  _consulasistencia(context, String codigocurso, int numerogrupo) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Asistencia"),
              content: Text(
                  "¿Esta seguro que desea registrar la asistencia de este curso "
                  " ?"),
              actions: [
                FloatingActionButton.large(
                  onPressed: () {
                    Navigator.pop(context);
                    //realizamos la matricula
                    _createAsistencia(codigocurso, numerogrupo);
                  },
                  child: Text("Matricular"),
                ),
                FloatingActionButton.large(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                  ),
                )
              ],
            ));
  }

  //Api Consulta Cursos por carrera
  static Future<List<EstudiantesGrupos>?> getCursos_Estudiante(
      String id) async {
    var url = Uri.parse(
        'http://apisprogravfinal.somee.com/api/Matriculas/Grupos_cursos_estudiante?id=' +
            id);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<EstudiantesGrupos> carreras = List<EstudiantesGrupos>.from(
          l.map((model) => EstudiantesGrupos.fromJson(model)));
      return carreras;
    } else {
      return null;
    }
  }

  void _createAsistencia(String codigocurso, int numerogrupo) async {
    var c = Asistencia();
    c
      ..numerogrupo = numerogrupo
      ..codigocurso = codigocurso
      ..fechaAsistencia = '2022-01-01'
      ..tipoasistencia = "Presente"
      ..tipoId = widget.tipoId
      ..identificacion = widget.id;

    var resultado = await matricula_service.postAsistencia(c);

    if (resultado == "201") {
      final snackBar =
          SnackBar(content: Text('La asistencia se registro con exito'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (resultado == "409") {
      final snackBar = SnackBar(
          content: Text('Ya existe un registro de asistencia para este curso'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (resultado == "500") {
      final snackBar = SnackBar(content: Text('Error de servidor'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (resultado == "") {
      final snackBar = SnackBar(content: Text('Error de servidor'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
