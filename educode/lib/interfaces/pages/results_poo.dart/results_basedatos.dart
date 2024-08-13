import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultsBasedatos extends StatelessWidget {
  final int score;
  final int total;

  ResultsBasedatos({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
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
                'Resultado de la base de datos:',
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
              style:
                  TextStyle(fontSize: 24, color: Colors.black), // Texto negro
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
