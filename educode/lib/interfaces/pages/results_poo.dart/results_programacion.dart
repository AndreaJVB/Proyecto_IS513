import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de importar GetX para usar Get.to()

class ResultsProgramacion extends StatelessWidget {
  final int score;
  final int total;

  ResultsProgramacion({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[100],
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tu puntaje final es: $score/$total',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
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
