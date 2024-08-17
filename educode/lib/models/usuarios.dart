class Usuarios{
  final String uid;
  final String nombreUsuario;

  Usuarios({
    required this.uid,
    required this.nombreUsuario
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
    uid: json["uid"],
    nombreUsuario: json["usuario"]);

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "usuario": nombreUsuario
  };
}