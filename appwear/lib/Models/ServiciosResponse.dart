class Serviciosresponse {
  final int id;
  final String codigo;
  final String nombre;
  final String descripcion;
  final double precio;
  final String estado;

  Serviciosresponse({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.estado,
  });

  factory Serviciosresponse.fromJson(Map<String, dynamic> json) {
    return Serviciosresponse(
      id: json['id'],
      codigo: json['codigo'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: double.parse(json['precio']),
      estado: json['estado'],
    );
  }
}
