// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_final_prograv/screen_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tipoidController = TextEditingController();
  var idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: tipoidController,
              decoration: InputDecoration(
                  labelText: "Tipo Identificación",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.perm_identity_rounded)),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: idController,
              decoration: InputDecoration(
                  labelText: "Identificación",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.verified_user_sharp)),
            ),
            SizedBox(
              height: 45,
            ),
            OutlinedButton.icon(
                onPressed: () {
                  ValidaEstudiante();
                },
                icon: Icon(
                  Icons.login_sharp,
                  size: 45,
                ),
                label: Text("Validar"))
          ],
        ))),
      ),
    );
  }

  //Metodo consume API
  Future<void> ValidaEstudiante() async {
    if (idController.text.isNotEmpty && tipoidController.text.isNotEmpty) {
      String tipoid = tipoidController.text;
      String identific = idController.text;

      var url = Uri.parse(
          'http://apisprogravfinal.somee.com/api/Estudiantes/Validaestudiante');
      var respuesta = await http.post(url,
          body: ({
            'tipo_ID': tipoid,
            'identificacion': identific,
          }));
      //validamos la respuesta
      if (respuesta.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => screen_main(tipoid, identific))));
        //  retorno = "200";
        // return retorno;
      }
      if (respuesta.statusCode == 404) {
        final snackBar =
            SnackBar(content: Text("Estudiante no se encuentra registrado"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //retorno = "404";
        //  return retorno;
      }
      if (respuesta.statusCode == 500) {
        final snackBar = SnackBar(content: Text("Error de servidor"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      final snackBar =
          SnackBar(content: Text("Por favor digite los valores requeridos"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // return retorno;
  }
}
