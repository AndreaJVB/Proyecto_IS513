import 'package:educode/controllers/historial_controller.dart';
import 'package:educode/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Agrega esta línea para usar json.encode y json.decode

class ResultsBasedatos extends StatelessWidget {
  final UserController getUser = Get.put<UserController>(UserController());
  final int score;
  final int total;
  final String topic;

  ResultsBasedatos(
      {required this.score, required this.total, required this.topic});

  Future<void> _saveResult() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final result = {
      'topic': topic,
      'score': score,
      'dateTime': now.toIso8601String(),
    };
    // Guarda el resultado en el historial (comentado como ejemplo).
    // final historyJson = prefs.getStringList('history') ?? [];
    // historyJson.add(json.encode(result));
    // await prefs.setStringList('history', historyJson);
  }

  // Método para calcular la puntuación en estrellas
  int _calculateStars() {
    double percentage = score / total;
    if (percentage == 1.0) {
      return 5; // 5 estrellas para 100% de aciertos
    } else if (percentage >= 0.8) {
      return 4; // 4 estrellas para 80%-99%
    } else if (percentage >= 0.6) {
      return 3; // 3 estrellas para 60%-79%
    } else if (percentage >= 0.4) {
      return 2; // 2 estrellas para 40%-59%
    } else if (percentage >= 0.2) {
      return 1; // 1 estrella para 20%-39%
    } else {
      return 0; // 0 estrellas para menos del 20%
    }
  }

  @override
  Widget build(BuildContext context) {
    int starCount = _calculateStars();

    return Scaffold(
      backgroundColor: Colors.indigoAccent[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.indigoAccent[100],
              child: Text(
                'Resultado de la base de datos:',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Puntaje: $score/$total',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  index < starCount ? Icons.star : Icons.star_border,
                  color: Colors.yellow[700],
                  size: 30,
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final now = DateTime.now();
                final HistorialController historialSave = HistorialController();
                historialSave.AgregarAlHistorial(
                    currentUser: getUser.user.value,
                    score: score,
                    now: now.toIso8601String(),
                    topic: topic);
                Get.offAllNamed('/solitario');
              },
              child: Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
