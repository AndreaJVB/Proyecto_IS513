import 'package:educode/controllers/quizz_controller.dart';
import 'package:educode/interfaces/pages/topic_pages/widgets/boton_volver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:educode/controllers/user_controller.dart';

class POOPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final url =
        'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/Programacion%20Orienta%20a%20Objeto.json';

    final QuizController controller = Get.put(QuizController(
      url: url,
      data1: 'POO',
      topic: 'Programación Orientada a Objetos',
    ));
    final UserController userController = Get.put(UserController());

    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'POO',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 10),
            Obx(() {
              return Text(
                '${controller.currentQuestionIndex.value + 1}/${controller.questions.length}',
                style: TextStyle(color: Colors.black, fontSize: 16),
              );
            }),
          ],
        ),
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
