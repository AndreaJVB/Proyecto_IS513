import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LenguajePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 5) {
          // Ajusta este valor para cambiar la sensibilidad
          Get.back();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lenguaje de programacion'),
        ),
        body: Center(
          child: Text('Página de Lenguaje de programacion'),
        ),
      ),
    );
  }
}
