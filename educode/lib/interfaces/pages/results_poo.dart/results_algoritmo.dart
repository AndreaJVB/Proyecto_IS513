import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultsAlgoritmo extends StatelessWidget {
  final int score;
  final int total;

  ResultsAlgoritmo({required this.score, required this.total});

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
