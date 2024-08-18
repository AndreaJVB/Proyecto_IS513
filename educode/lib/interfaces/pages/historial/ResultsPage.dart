import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Asegúrate de que esto esté importado

class ResultsPage extends StatelessWidget {
  final int score;
  final int total;
  final DateTime dateTime; // Añade esta variable si necesitas mostrar la fecha

  ResultsPage({
    required this.score,
    required this.total,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(dateTime); // Usa la variable

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
            Text(
              'Fecha y hora: $formatted', // Muestra la fecha formateada
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // Texto negro
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar al inicio
              },
              child: Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
