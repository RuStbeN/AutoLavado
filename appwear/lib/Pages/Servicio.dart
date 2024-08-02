import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appwear/Utils/Ambiente.dart';
import 'package:appwear/Models/ServiciosResponse.dart';
import 'package:appwear/Pages/Etapa.dart';
import 'package:quickalert/quickalert.dart';

class Servicio extends StatefulWidget {
  final int idServicio;
  const Servicio({Key? key, required this.idServicio}) : super(key: key);

  @override
  State<Servicio> createState() => _ServicioState();
}

class _ServicioState extends State<Servicio> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController txtCodigo = TextEditingController();
  final TextEditingController txtNombre = TextEditingController();
  final TextEditingController txtDescripcion = TextEditingController();
  final TextEditingController txtPrecio = TextEditingController();
  final TextEditingController txtEstado = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.idServicio != 0) {
      fnDatosServicios();
    }
  }

  void fnDatosServicios() async {
    final response = await http.post(
      Uri.parse('${Ambiente.uriServer}/api/servicio'),
      body: jsonEncode(<String, dynamic>{
        'id': widget.idServicio,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    final servicioResponse = Serviciosresponse.fromJson(responseJson);

    setState(() {
      txtCodigo.text = servicioResponse.codigo;
      txtNombre.text = servicioResponse.nombre;
      txtDescripcion.text = servicioResponse.descripcion;
      txtPrecio.text = servicioResponse.precio.toString();
      txtEstado.text= servicioResponse.estado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulario Servicios"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextField(txtCodigo, 'Código'),
                  const SizedBox(height: 5),
                  _buildTextField(txtNombre, 'Nombre'),
                  const SizedBox(height: 5),
                  _buildTextField(txtDescripcion, 'Descripción'),
                  const SizedBox(height: 5),
                  _buildTextField(txtPrecio, 'Precio', isNumeric: true),
                  const SizedBox(height: 5),
                  _buildTextField(txtEstado, 'Estado'),
                  const SizedBox(height: 10),
                  _buildButton('Aceptar', Colors.green, _saveService),
                  if (widget.idServicio != 0) ...[
                    const SizedBox(height: 5),
                    _buildButton('Eliminar', Colors.red, _deleteService),
                    const SizedBox(height: 5),
                    _buildButton('Etapas', Colors.yellow, _navigateToEtapa),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, llene este campo';
        }
        return null;
      },
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      child: Text(text),
    );
  }

  void _saveService() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('${Ambiente.uriServer}/api/servicio/guardar'),
        body: jsonEncode(<String, dynamic>{
          'id': widget.idServicio,
          'codigo': txtCodigo.text,
          'nombre': txtNombre.text,
          'descripcion': txtDescripcion.text,
          'precio': txtPrecio.text,
          'estado': txtEstado.text,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
      );

      print(response.body);
      if (response.body == 'OK') {
        Navigator.pop(context);
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: response.body,
        );
      }
    }
  }

  void _deleteService() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.delete(
        Uri.parse('${Ambiente.uriServer}/api/servicio/borrar/${widget.idServicio}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
      );
      print(response.body);
      if (response.body == 'OK') {
        Navigator.pop(context);
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: response.body,
        );
      }
    }
  }

  void _navigateToEtapa() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Etapa(idServicios: widget.idServicio),
      ),
    );
  }
}
