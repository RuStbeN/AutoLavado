import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart'; // Asegúrate de importar las librerías necesarias
import 'package:proyect_9ids2/Utils/Ambiente.dart'; // Asegúrate de importar las librerías necesarias

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
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
              controller: txtName,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextField(
              controller: txtEmail,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            TextField(
              controller: txtPassword,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            TextButton(
              onPressed: () async {
                final response = await http.post(
                  Uri.parse('${Ambiente.uriServer}/api/register'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, dynamic>{
                    'name': txtName.text,
                    'email': txtEmail.text,
                    'password': txtPassword.text,
                  }),
                );

                if (response.statusCode == 201) {
                  // Registro exitoso
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Registro Exitoso',
                    text: 'Usuario registrado correctamente.',
                  );
                } else {
                  // Error en el registro
                  Map<String, dynamic> responseJson = jsonDecode(response.body);
                  final error = responseJson['error'] ?? 'Error desconocido';
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Error en el Registro',
                    text: error,
                  );
                }
              },
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
