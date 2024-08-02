import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:appwear/Models/EtapasResponse.dart';
import 'package:appwear/Utils/Ambiente.dart';

class Etapa extends StatefulWidget {
  final int idServicios;
  const Etapa({Key? key, required this.idServicios}) : super(key: key);

  @override
  _EtapaState createState() => _EtapaState();
}

class _EtapaState extends State<Etapa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtNombre = TextEditingController();
  final TextEditingController txtDuracion = TextEditingController();
  List<EtapasResponse> etapas = [];
  int? editingId; // Variable para almacenar el ID de la etapa que se está editando

  @override
  void initState() {
    super.initState();
    if (widget.idServicios != 0) {
      fnDatosEtapas();
    }
  }

  void fnDatosEtapas() async {
    try {
      final response = await http.get(
        Uri.parse('${Ambiente.uriServer}/api/etapas/${widget.idServicios}'),
        headers: <String, String>{'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> responseJson = jsonDecode(response.body);
        setState(() {
          etapas = responseJson.map((e) => EtapasResponse.fromJson(e)).toList();
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Error al obtener las etapas. Código de estado: ${response.statusCode}',
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

  void guardarEtapa() async {
    int duracion = int.tryParse(txtDuracion.text) ?? 0;

    final response = await http.post(
      Uri.parse('${Ambiente.uriServer}/api/etapa/${editingId == null ? 'guardar' : 'actualizar/$editingId'}'),
      body: jsonEncode(<String, dynamic>{
        'id_servicios': widget.idServicios,
        'nombre': txtNombre.text,
        'duracion': duracion,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
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
    editingId = null; // Resetear el ID de edición después de guardar
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
      fnDatosEtapas();
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: response.body,
      );
    }
  }

  void editarEtapa(EtapasResponse etapa) {
    txtNombre.text = etapa.nombre;
    txtDuracion.text = etapa.duracion.toString();
    editingId = etapa.id; // Guardar el ID de la etapa que se está editando

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Editar Etapa'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: txtNombre,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, llene este campo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: txtDuracion,
                      decoration: InputDecoration(
                        labelText: 'Duración',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, llene este campo';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop(); // Cerrar el diálogo
                      guardarEtapa(); // Guardar los cambios
                    }
                  },
                  child: Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulario Etapas"),
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
                    ? Center(child: Text('No hay etapas para este servicio', style: TextStyle(color: Colors.white)))
                    : ListView.builder(
                  itemCount: etapas.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            editarEtapa(etapas[index]); // Llamar a editarEtapa con la etapa seleccionada
                          },
                        ),
                        title: Text(etapas[index].nombre),
                        subtitle: Text('Duración: ${etapas[index].duracion.toString()}'),
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
              Form(
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
                      keyboardType: TextInputType.number,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
