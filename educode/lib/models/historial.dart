class Historial {
  final DateTime hFinal;
  final DateTime hInicial;
  final int puntuacion;
  final String tema;
  final String uidUsuario;

  Historial(
    {
      required this.hFinal,
      required this.hInicial,
      required this.puntuacion,
      required this.tema,
      required this.uidUsuario
    }
  );

  factory Historial.fromJson(Map<String, dynamic> json) => Historial(
    hFinal: json['final'], 
    hInicial: json['inicio'], 
    puntuacion: json['puntuacion'], 
    tema: json['tema'], 
    uidUsuario: json['uid_usuario']);

  Map<String, dynamic> toJson() => {
    "final": hFinal,
    "inicio": hInicial,
    "puntuacion": puntuacion,
    "uid_usuario": uidUsuario
  };
}