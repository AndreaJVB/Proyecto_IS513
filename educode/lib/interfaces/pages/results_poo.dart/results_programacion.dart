import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de importar GetX para usar Get.to()
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Importar para codificar JSON

class ResultsProgramacion extends StatelessWidget {
  final int score;
  final int total;

  ResultsProgramacion({required this.score, required this.total});

  Future<void> _saveResult() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('history') ?? [];

    final newResult = {
      'topic': 'Programación',
      'score': score,
      'dateTime': DateTime.now().toIso8601String(),
    };

    historyJson.add(json.encode(newResult));
    await prefs.setStringList('history', historyJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100], // Fondo azul claro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.blue[100], // Fondo azul claro para el contenedor
              child: Text(
                'Resultado de Programación:',
                style: TextStyle(
                  fontSize: 22, // Tamaño de letra 22
                  color: Colors.black, // Texto negro
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Puntaje: $score/$total',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black, // Texto negro
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveResult(); // Guardar el resultado antes de navegar
                Get.offAllNamed(
                    '/solitario'); // Navegar a la pantalla principal
              },
              child: Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
