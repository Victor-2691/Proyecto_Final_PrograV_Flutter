import 'package:flutter/material.dart';
import 'package:proyecto_final_prograv/main.dart';
import 'package:proyecto_final_prograv/matricula.dart';

class screen_main extends StatefulWidget {
  @override
  State<screen_main> createState() => _screen_mainState();
}

class _screen_mainState extends State<screen_main> {
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
            SizedBox(
              height: 45,
            ),
            OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => matricula())));
                  //codigo boton matricular aqui
                },
                icon: Icon(
                  Icons.app_registration_outlined,
                  size: 30,
                ),
                label: Text("Matricular")),
            OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.assignment,
                  size: 30,
                ),
                label: Text("Asistencia")),
            OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => MyHomePage())));
                },
                icon: Icon(
                  Icons.logout_outlined,
                  size: 30,
                ),
                label: Text("Salir")),
          ],
        ))),
      ),
    );
  }
}
