import 'package:educode/interfaces/pages/home/widgets/escoger_categoria.dart';
import 'package:educode/interfaces/pages/topic_pages/mixto_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BotonCategoriaMixta extends StatelessWidget {
  const BotonCategoriaMixta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final Map<String, List<String>> map = {};
        final seleccionadas = await Get.dialog<List<String>>(
          EscogerCategoria(),
        );
        if (seleccionadas != null && seleccionadas.length >= 2) {
          // Navigate to the appropriate screen with the selected categories
          for (final categoria in seleccionadas) {
            if (categoria == 'Base de Datos') {
              map[categoria] = [
                'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/basedatos.json',
                'BASE_DATOS'
              ];
            }
            if (categoria == 'Algoritmos') {
              map[categoria] = [
                'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/algoritmo.json',
                'algoritmo'
              ];
            }
            if (categoria == 'Lenguaje de Programación') {
              map[categoria] = [
                'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/flutter.json',
                'Flutter'
              ];
            }
            if (categoria == 'Programación Orientada a Objetos') {
              map[categoria] = [
                'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/Programacion%20Orienta%20a%20Objeto.json',
                'POO'
              ];
            }
            if (categoria == 'Programación') {
              map[categoria] = [
                'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/programacion.json',
                'programacion'
              ];
            }
          }
          print('Categorías seleccionadas: $map');
          Get.offAll(MixtoPage(map: map));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF3A6073),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      ),
      child: Column(
        children: [
          Icon(Icons.library_books_outlined, size: 40, color: Colors.white),
          SizedBox(height: 10),
          Text('Mixto', style: TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }
}
