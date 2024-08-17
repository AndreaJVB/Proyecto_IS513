import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ResultsAlgoritmo extends StatelessWidget {
  final int score;
  final int total;

  ResultsAlgoritmo({required this.score, required this.total});

  Future<void> _saveResult() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final formattedDate = now.toIso8601String();

    final result = {
      'userName': 'User', // Cambia esto según el nombre del usuario
      'topic': 'Algoritmo',
      'score': score,
      'dateTime': formattedDate,
    };

    List<String> history = prefs.getStringList('history') ?? [];
    history.add(json.encode(result));
    await prefs.setStringList('history', history);
  }

  @override
  Widget build(BuildContext context) {
    // Guardar el resultado cuando la pantalla se construya
    _saveResult();

    return Scaffold(
      backgroundColor: Colors.indigoAccent[100], // Fondo indigoAccent[100]
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.indigoAccent[100], // Fondo indigoAccent[100]
              child: Text(
                'Resultado del algoritmo:',
                style: TextStyle(
                  fontSize: 22, // Tamaño de letra 22
                  color: Colors.black, // Letras negras
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
              onPressed: () {
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
