import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Programacion1Page extends StatelessWidget {
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
          title: Text('Programacion 1'),
        ),
        body: Center(
          child: Text('Página de Programacion 1'),
        ),
      ),
    );
  }
}
