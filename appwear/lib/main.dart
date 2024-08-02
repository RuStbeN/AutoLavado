import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:appwear/Pages/Login.dart'; // Asegúrate de importar la pantalla de login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(), // Redirige a la pantalla de login
    );
  }
}
