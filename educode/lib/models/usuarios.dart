class Usuarios{
  final String nombreUsuario;

  Usuarios({
    required this.nombreUsuario
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
    nombreUsuario: json["usuario"]);

  Map<String, dynamic> toJson() => {
    "usuario": nombreUsuario
  };
}