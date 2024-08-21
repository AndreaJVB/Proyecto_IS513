import 'package:educode/controllers/mixto_controller.dart';
import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/topic_pages/widgets/boton_volver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MixtoPage extends StatelessWidget {
  const MixtoPage({super.key, required this.map});

  final Map<String, List<String>> map;

  @override
  Widget build(BuildContext context) {
    final MixtoController controller = Get.put(MixtoController(map: map));
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Obx(() {
          return controller.isLoading.value
              ? Text(
                  'Cargando...',
                  style: TextStyle(color: Colors.white),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tema: ${controller.questions.isNotEmpty ? controller.questions[controller.currentQuestionIndex.value]['tema'] : ''}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'Pregunta ${controller.currentQuestionIndex.value + 1}/${controller.questions.length}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                );
        }),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.questions.isEmpty) {
          return Center(child: Text('No hay preguntas disponibles.'));
        }

        final question =
            controller.questions[controller.currentQuestionIndex.value];
        final options = question['opciones'] as Map<String, dynamic>;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    question['pregunta'],
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                ...options.entries.map((entry) {
                  final isSelected =
                      controller.selectedOption.value == entry.key;
                  final isCorrect = entry.key == question['respuesta_marcada'];
                  final color = isSelected
                      ? (isCorrect ? Colors.green : Colors.red)
                      : Colors.white;

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      onPressed: () => controller.answerQuestion(entry.key),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        entry.value,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tiempo restante:',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.timer, // Icono de cronómetro junto a los segundos
                      color: Colors.black,
                      size: 24,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${controller.timeLeft.value} segundos',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                BotonRegresarHome(userController: userController),
              ],
            ),
          ),
        );
      }),
    );
  }
}
