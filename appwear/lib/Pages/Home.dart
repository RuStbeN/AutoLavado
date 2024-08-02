import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appwear/Utils/Ambiente.dart';
import 'package:appwear/Models/ServiciosResponse.dart';
import 'package:appwear/Pages/Servicio.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Serviciosresponse> servicios = [];

  Widget _listViewServicios() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      itemCount: servicios.length,
      itemBuilder: (context, index) {
        var servicio = servicios[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Servicio(
                    idServicio: servicio.id,
                  ),
                ),
              );
            },
            title: Text(
              servicio.codigo,
              style: TextStyle(fontSize: 14.0),
            ),
            subtitle: Text(
              servicio.descripcion,
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        );
      },
    );
  }

  void fnObtenerServicios() async {
    var response = await http.get(
      Uri.parse('${Ambiente.uriServer}/api/servicios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );

    print(response.body);

    Iterable mapServicios = jsonDecode(response.body);
    servicios = List<Serviciosresponse>.from(
      mapServicios.map((model) => Serviciosresponse.fromJson(model)),
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fnObtenerServicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Column(
                children: [
                  const Expanded(
                    child: Image(image: AssetImage('images/auto.png')),
                  ),
                  Text(
                    Ambiente.nombreUsuario,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.cleaning_services),
              title: const Text('Servicios', style: TextStyle(fontSize: 14.0)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Servicio(idServicio: 0),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Servicios', style: TextStyle(fontSize: 16.0)),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return {'Actualizar lista'}.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
            onSelected: (String value) {
              if (value == 'Actualizar lista') {
                fnObtenerServicios();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _listViewServicios(),
              const SizedBox(height: 16.0),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Servicio(idServicio: 0),
                    ),
                  );
                },
                child: const Icon(Icons.add_business),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
