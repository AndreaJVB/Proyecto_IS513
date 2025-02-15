import 'package:educode/controllers/quizz_controller.dart';
import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/topic_pages/widgets/boton_volver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlgoritmoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final url =
        'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/algoritmo.json';

    final QuizController controller = Get.put(
        QuizController(url: url, data1: 'algoritmo', topic: 'Algoritmo'));
    final UserController userController = Get.put(UserController());

    return Scaffold(
      backgroundColor:
          Colors.grey[500], // Fondo oscuro de la pantalla principal
      appBar: AppBar(
        backgroundColor:
            Colors.deepPurple[700], // Fondo de la AppBar en color morado oscuro
        title: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Algoritmo ${controller.currentQuestionIndex.value + 1}/${controller.questions.length}',
                style:
                    TextStyle(color: Colors.black), // Texto del título en negro
              ),
            ],
          );
        }),
        automaticallyImplyLeading: false, // Elimina el botón de regreso
      ),
      body: Obx(() {
        if (controller.questions.isEmpty) {
          return Center(child: CircularProgressIndicator());
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
                    color: Colors
                        .white, // Fondo blanco para la caja de la pregunta
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
                      onPressed: () {
                        controller.answerQuestion(entry.key);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor:
                            color, // Cambia el fondo según la selección
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
                    Icon(
                      Icons.timer, // Icono de cronómetro
                      color: Colors.black,
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Tiempo restante: ${controller.timeLeft.value} segundos',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
