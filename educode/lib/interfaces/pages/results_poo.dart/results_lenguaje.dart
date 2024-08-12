import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de importar GetX para usar Get.to()

class ResultsLenguaje extends StatelessWidget {
  final int score;
  final int total;

  ResultsLenguaje({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Puntaje: $score/$total',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla SolitarioPage
                Get.offAllNamed(
                    '/solitario'); // Asegúrate de que '/solitario' esté registrado en las rutas
              },
              child: Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
