import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:proyect_9ids2/Models/EtapasResponse.dart'; // Asegúrate de importar correctamente tu modelo de EtapasResponse
import 'package:proyect_9ids2/Utils/Ambiente.dart';

class Etapa extends StatefulWidget {
  final int id_servicios;

  const Etapa({Key? key, required this.id_servicios}) : super(key: key);

  @override
  _EtapaState createState() => _EtapaState();
}

class _EtapaState extends State<Etapa> {
  List<EtapasResponse> etapas = [];

  @override
  void initState() {
    super.initState();
    fnDatosEtapas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Etapas"),
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: etapas.isEmpty
                    ? Center(
                  child: Text(
                    'No hay etapas para este servicio',
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : ListView.builder(
                  itemCount: etapas.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(etapas[index].nombre),
                        subtitle:
                        Text('Duración: ${etapas[index].duracion}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            eliminarEtapa(etapas[index].id);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              EtapaForm(idServicios: widget.id_servicios, onEtapaGuardada: () {
                fnDatosEtapas(); // Actualizar lista de etapas después de guardar
              }),
            ],
          ),
        ),
      ),
    );
  }

  void fnDatosEtapas() async {
    try {
      final response = await http.get(
        Uri.parse('${Ambiente.uriServer}/api/etapas/${widget.id_servicios}'),
        headers: <String, String>{
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseJson = jsonDecode(response.body);
        setState(() {
          etapas = responseJson.map((e) {
            return EtapasResponse.fromJson(e);
          }).toList();
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text:
          'No hay etapas en este servicio',
        );
      }
    } catch (e) {
      print('Excepción atrapada: $e');
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Error al obtener las etapas. Detalles: $e',
      );
    }
  }

  void eliminarEtapa(int idEtapa) async {
    final response = await http.delete(
      Uri.parse('${Ambiente.uriServer}/api/etapa/borrar/$idEtapa'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );

    if (response.body == 'OK') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: '¡Éxito!',
        text: 'Etapa eliminada correctamente.',
      );
      fnDatosEtapas(); // Refresca la lista de etapas después de eliminar
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

class EtapaForm extends StatefulWidget {
  final int idServicios;
  final Function onEtapaGuardada;

  const EtapaForm({
    Key? key,
    required this.idServicios,
    required this.onEtapaGuardada,
  }) : super(key: key);

  @override
  _EtapaFormState createState() => _EtapaFormState();
}

class _EtapaFormState extends State<EtapaForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtDuracion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: txtNombre,
            decoration: InputDecoration(
              labelText: 'Nombre',
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, llene este campo';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: txtDuracion,
            decoration: InputDecoration(
              labelText: 'Duración',
              labelStyle: TextStyle(color: Colors.white),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.text, // Permitir texto para la duración
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, llene este campo';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                guardarEtapa();
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void guardarEtapa() async {
    // Convertir txtDuracion.text a entero
    int duracion = int.tryParse(txtDuracion.text) ?? 0;

    final response = await http.post(
      Uri.parse('${Ambiente.uriServer}/api/etapa/guardar'),
      body: jsonEncode(<String, dynamic>{
        'id_servicios': widget.idServicios,
        'nombre': txtNombre.text,
        'duracion': duracion, // Enviar duración como entero
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );

    if (response.body == 'OK') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: '¡Éxito!',
        text: 'Etapa guardada correctamente.',
      );
      widget.onEtapaGuardada(); // Llama a la función de callback para actualizar la lista de etapas
      txtNombre.clear(); // Limpiar campos después de guardar
      txtDuracion.clear();
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
