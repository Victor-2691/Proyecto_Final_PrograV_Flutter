import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_final_prograv/class_grupos.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final_prograv/class_matricula.dart';
import 'package:proyecto_final_prograv/class_service_matricula.dart';

class grupos_screen extends StatefulWidget {
  final String tipoid;
  final String id;
  final String codigocurso;
  const grupos_screen(this.tipoid, this.id, this.codigocurso, {super.key});

  @override
  State<grupos_screen> createState() => _grupos_screenState();
}

class _grupos_screenState extends State<grupos_screen> {
  List<Grupos> data = <Grupos>[];

  void initState() {
    super.initState();
    getGrupos(widget.codigocurso).then((value) {
      setState(() {
        data.addAll(value!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Grupos")),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                //Con la propiedad onTap agregamos funcioanlidad al trailing que es la fecla que se muestra al final
                onLongPress: () {
                  _consultamatricula(context, data[index].numeroGrupo);
                },
                title: Text("Numero Grupo : " +
                    data[index].numeroGrupo.toString() +
                    " " +
                    "Horario : " +
                    data[index].horario),
                subtitle: Text("Profesor : " +
                    data[index].nombre +
                    " " +
                    data[index].primerApellido +
                    " " +
                    data[index].segundoApellido),
                leading: CircleAvatar(child: Text(data[index].anno.toString())),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              );
            }));
  }

  //Consume API Grupos
  static Future<List<Grupos>?> getGrupos(String codigoCurso) async {
    var url = Uri.parse(
        'http://apisprogravfinal.somee.com/api/Grupos/GetGruposPorCurso?CodCurso=' +
            codigoCurso);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Grupos> carreras =
          List<Grupos>.from(l.map((model) => Grupos.fromJson(model)));
      return carreras;
    } else {
      return null;
    }
  }

  _consultamatricula(context, int numrogrupo) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Matricular grupo"),
              content: Text("¿Esta seguro que desea matricular el curso "
                  " ?"),
              actions: [
                FloatingActionButton.large(
                  onPressed: () {
                    Navigator.pop(context);
                    //realizamos la matricula
                    _createMatricula(numrogrupo);
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

  void _createMatricula(int numrogrupo) async {
    var c = Matricula();
    c
      ..tipoIdEstudiante = widget.tipoid
      ..identificacionEstudiante = widget.id
      ..codigocurso = widget.codigocurso
      ..numerogrupo = numrogrupo
      ..tipomatricula = "Normal"
      ..nota = 0;
    var resultado = await matricula_service.postmatricula(c);

    if (resultado == "201") {
      final snackBar = SnackBar(
          content: Text(
              'El curso se matriculo en el grupo seleccionado de forma exitosa'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    if (resultado == "409") {
      final snackBar = SnackBar(
          content:
              Text('El estudiante ya se encuentra matriculado en el grupo'));
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
