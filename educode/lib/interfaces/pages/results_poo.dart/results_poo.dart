import 'package:flutter/material.dart';

class ResultsPOO extends StatelessWidget {
  final int score;
  final int total;

  ResultsPOO({required this.score, required this.total});

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
            Text('Puntaje: $score/$total', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
