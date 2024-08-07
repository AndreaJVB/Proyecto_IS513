import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasedatosPage extends StatelessWidget {
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
          title: Text('Base de Datos'),
        ),
        body: Center(
          child: Text('Página de Base de Datos'),
        ),
      ),
    );
  }
}
