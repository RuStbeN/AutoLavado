class Serviciosresponse{
  final int id;
  final String codigo;
  final String nombre;
  final String descripcion;
  final double precio;

  Serviciosresponse(this.id,
      this.codigo,
      this.nombre,
      this.descripcion,
      this.precio);

  Serviciosresponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        codigo = json['codigo'],
        nombre = json['nombre'],
        descripcion = json['descripcion'],
        precio = double.parse(json['precio']);

}