import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class WheelPage extends StatelessWidget {
  final List<String> topics = [
    "Base de datos",
    "Programación 1",
    "Programación 2",
    "Algoritmo",
    "Lenguaje de Programación"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rueda de Temas'),
      ),
      body: Center(
        child: FortuneWheel(
          items: [
            for (var topic in topics) FortuneItem(child: Text(topic)),
          ],
        ),
      ),
    );
  }
}
