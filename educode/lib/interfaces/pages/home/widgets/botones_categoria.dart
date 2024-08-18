import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriaBoton extends StatelessWidget {
  const CategoriaBoton(
      {super.key,
      required this.nombre,
      required this.icono,
      required this.texto});
  final String nombre;
  final IconData icono;
  final String texto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () => Get.offAllNamed(nombre),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3A6073),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
        child: Column(
          children: [
            Icon(icono, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(texto, style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}