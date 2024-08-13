import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de importar GetX para usar Get.to()

class ResultsProgramacion extends StatelessWidget {
  final int score;
  final int total;

  ResultsProgramacion({required this.score, required this.total});

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
