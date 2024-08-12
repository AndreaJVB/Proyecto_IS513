import 'package:flutter/material.dart';

class ResultsBasedatos extends StatelessWidget {
  final int score;
  final int total;

  ResultsBasedatos({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent[100],
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Center(
        child: Text(
          'Tu puntaje final es: $score/$total',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
