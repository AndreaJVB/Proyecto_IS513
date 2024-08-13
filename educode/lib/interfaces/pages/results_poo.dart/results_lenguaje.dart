import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultsLenguaje extends StatelessWidget {
  final int score;
  final int total;

  ResultsLenguaje({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100], // Fondo azul[100]
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.blue[100], // Fondo azul[100]
              child: Text(
                'Resultado del lenguaje de programación fue de:',
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
              style: TextStyle(fontSize: 24),
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
