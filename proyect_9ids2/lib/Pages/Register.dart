import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: txtName,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtEmail,
              decoration: const InputDecoration(labelText: 'Correo electrónico'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: txtPassword,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
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
                    final error = responseJson['message'] ?? 'Error desconocido';
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Error en el Registro',
                      text: error,
                    );
                  }
                } catch (e) {
                  // Error de red u otros errores
                  print('Error en la solicitud HTTP: $e');
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Error',
                    text: 'Hubo un problema durante el registro. Por favor, intenta nuevamente.',
                  );
                }
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
