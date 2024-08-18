class Historial {
  
  final String now;
  final int puntuacion;
  final String topic;

  Historial(
    {
      required this.now,
      required this.puntuacion,
      required this.topic,
    }
  );

  factory Historial.fromJson(Map<String, dynamic> json) => Historial(
 
    now: json['inicio'], 
    puntuacion: json['puntuacion'], 
    topic: json['tema'],);

  Map<String, dynamic> toJson() => {
    
    "inicio": now,
    "puntuacion": puntuacion,
    "tema": topic
  };
}