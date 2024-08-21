import 'package:educode/interfaces/pages/home/widgets/escoger_categoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BotonCategoriaMixtaMultijugador extends GetxController {

  final map = <String, List<String>>{}.obs;
  final listaMostrar = <String>["Elige un tema"].obs; // Usar Set para evitar duplicados
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final seleccionadas = await Get.dialog<List<String>>(
          EscogerCategoria(),
        );
        if (seleccionadas != null && seleccionadas.length >= 2) {
          // Limpia las categorías existentes antes de añadir nuevas
          map.clear();
          listaMostrar.clear();
          listaMostrar.add("Elige un tema");
          
          // Añadir solo categorías no presentes en el mapa
          for (final categoria in seleccionadas) {
            if (!map.containsKey(categoria)) { // Verificar si ya está en el mapa
              if (categoria == 'Base de Datos') {
                map[categoria] = [
                  'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/basedatos.json',
                  'BASE_DATOS'
                ];
                listaMostrar.add("Base de Datos");
              }
              if (categoria == 'Algoritmos') {
                map[categoria] = [
                  'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/algoritmo.json',
                  'algoritmo'
                ];
                listaMostrar.add("Algoritmo");
              }
              if (categoria == 'Lenguaje de Programación') {
                map[categoria] = [
                  'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/flutter.json',
                  'Flutter'
                ];
                listaMostrar.add("Lenguaje de Programación");
              }
              if (categoria == 'Programación Orientada a Objetos') {
                map[categoria] = [
                  'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/Programacion%20Orienta%20a%20Objeto.json',
                  'POO'
                ];
                listaMostrar.add("POO");
              }
              if (categoria == 'Programación') {
                map[categoria] = [
                  'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/programacion.json',
                  'programacion'
                ];
                listaMostrar.add("Programación");
              }
            }
          }
          print('Categorías seleccionadas: $map');
          // Add navigation logic here if needed
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
              'Escoge tus preguntas',
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
