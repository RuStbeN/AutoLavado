import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyect_9ids2/Models/ServiciosResponse.dart';
import 'package:proyect_9ids2/Pages/Servicio.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Serviciosresponse> servicios = [];
  
  Widget _listViewServicios(){
    return ListView.builder(
      itemCount: servicios.length,
        itemBuilder: (context, index){
          var servicio = servicios[index];  
          
          return ListTile(
            title: Text(servicio.codigo),
            subtitle: Text(servicio.descripcion),
          );
        }
      );

  }
  
  
  void fnObtenerServicios() async {
    var response = await
    http.get(Uri.parse('http://192.168.56.1:8000/api/servicios'),
        headers: <String, String>{
          'Content-Type' : 'application/json; charset=UTF-8',
          'Accept' : 'application/json'
        },
        );

    print(response.body);

    Iterable mapServicios = jsonDecode(response.body);
    servicios = List<Serviciosresponse>
    .from(mapServicios.map((model) =>
    Serviciosresponse.fromJson(model)));

  setState(() {

  });
      }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnObtenerServicios();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios'),
      ),
      body: _listViewServicios(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(
              builder: (context)=> const Servicio()),
          );
        },
        child: Icon(Icons.add_business),
    ),
    );
  }
}
