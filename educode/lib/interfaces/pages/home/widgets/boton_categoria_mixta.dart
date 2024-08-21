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
    return GestureDetector(
      onTap: () async {
        final Map<String, List<String>> map = {};
        final seleccionadas = await Get.dialog<List<String>>(
          EscogerCategoria(cantidad: 2,),
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
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/mixto.jpg',
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Preguntas Mixtas',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
