import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appwear/Models/LoginResponse.dart';
import 'package:appwear/Pages/Home.dart';
import 'package:appwear/Pages/Register.dart';
import 'package:quickalert/quickalert.dart';
import 'package:appwear/Utils/Ambiente.dart';

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
        automaticallyImplyLeading: false, // Evita que se muestre el botón de regreso en la app bar
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://cdn-icons-png.flaticon.com/512/5087/5087579.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                    ),
                    controller: txtUser,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                    ),
                    controller: txtPass,
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
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
                        Map<String, dynamic> responseJson = jsonDecode(response.body);
                        final loginResponse = Loginresponse.fromJson(responseJson);

                        if (loginResponse.acceso == "OK") {
                          Ambiente.nombreUsuario = loginResponse.nombreUsuario;

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
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Error',
                          text: 'Error en la autenticación. Código de estado: ${response.statusCode}',
                        );
                      }
                    },
                    child: const Text('Ingresar'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
