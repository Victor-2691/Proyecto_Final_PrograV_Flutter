import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final_prograv/screen_main.dart';

import 'carreras.dart';

class matricula extends StatefulWidget {
  @override
  State<matricula> createState() => _matriculaState();
}

class _matriculaState extends State<matricula> {
  List<Carreras> data = <Carreras>[];

  void initState() {
    super.initState();

    getCarreras().then((value) {
      setState(() {
        data.addAll(value!);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Carreras")),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                //Con la propiedad onTap agregamos funcioanlidad al trailing que es la fecla que se muestra al final
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => screen_main())));

                  //Por ejemplo capturar los datos como el codigo de la carrera y pasarlo a otra pantalla
                  //Codigo cuando da click a algun elemento
                  //con el onLongPress funciona dejando presionado el control
                },
                title: Text(data[index].nombreCarrera),
                subtitle: Text(data[index].codigoCarrera),
                leading: CircleAvatar(child: Text(data[index].codigoCarrera)),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              );
            }));
  }

  //Api Consulta Carreras
  static Future<List<Carreras>?> getCarreras() async {
    var url = Uri.parse(
        'http://apisprogravfinal.somee.com/api/Carreras/ConsultaCarreras');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Carreras> carreras =
          List<Carreras>.from(l.map((model) => Carreras.fromJson(model)));
      return carreras;
    } else {
      return null;
    }
  }
}
