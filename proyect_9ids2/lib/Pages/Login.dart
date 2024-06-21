import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyect_9ids2/Models/LoginResponse.dart'; // Asegúrate de importar los modelos necesarios
import 'package:proyect_9ids2/Pages/Home.dart';
import 'package:proyect_9ids2/Pages/Register.dart'; // Importa la pantalla de registro
import 'package:quickalert/quickalert.dart'; // Asegúrate de importar las librerías necesarias
import 'package:proyect_9ids2/Utils/Ambiente.dart'; // Asegúrate de importar las librerías necesarias

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController txtUser = TextEditingController();
  final TextEditingController txtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/5087/5087579.png',
              width: 250,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Usuario',
              ),
              controller: txtUser,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
              controller: txtPass,
              obscureText: true,
            ),
            TextButton(
              onPressed: () async {
                final response = await http.post(
                  Uri.parse('${Ambiente.uriServer}/api/login'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, dynamic>{
                    'email': txtUser.text,
                    'password': txtPass.text,
                  }),
                );

                if (response.statusCode == 200) {
                  // Éxito en la autenticación
                  Map<String, dynamic> responseJson = jsonDecode(response.body);
                  final loginResponse = Loginresponse.fromJson(responseJson);

                  if (loginResponse.acceso == "OK") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops.....!',
                      text: loginResponse.error ?? 'Error desconocido',
                    );
                  }
                } else {
                  // Error en la autenticación
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Error',
                    text: 'Error en la autenticación. Código de estado: ${response.statusCode}',
                  );
                }
              },
              child: Text('Ingresar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
