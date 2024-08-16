import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Agrega esta línea para usar json.encode y json.decode

class ResultsBasedatos extends StatelessWidget {
  final int score;
  final int total;

  ResultsBasedatos({required this.score, required this.total});

  Future<void> _saveResult() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final result = {
      'topic': 'Base de Datos',
      'score': score,
      'dateTime': now.toIso8601String(),
    };

    final historyJson = prefs.getStringList('history') ?? [];
    historyJson.add(json.encode(result));
    await prefs.setStringList('history', historyJson);
  }

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(
              onPressed: () async {
                await _saveResult();
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
