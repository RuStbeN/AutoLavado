class EtapasResponse {
  final int id;
  final int id_servicios;
  final String nombre;
  final String duracion;

  EtapasResponse({
    required this.id,
    required this.id_servicios,
    required this.nombre,
    required this.duracion,
  });

  factory EtapasResponse.fromJson(Map<String, dynamic> json) {
    return EtapasResponse(
      id: json['id'],
      id_servicios: json['id_servicios'],
      nombre: json['nombre'],
      duracion: json['duracion'],
    );
  }
}
