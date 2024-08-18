import 'package:educode/controllers/quizz_controller.dart';
import 'package:educode/interfaces/pages/results_poo.dart/widgets/boton_volver.dart';
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
      backgroundColor:
          Colors.grey[500], // Fondo oscuro de la pantalla principal
      appBar: AppBar(
        backgroundColor:
            Colors.deepPurple[700], // Fondo de la AppBar en color morado oscuro
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'POO', // Título estático
              style:
                  TextStyle(color: Colors.black), // Texto del título en negro
            ),
            SizedBox(width: 10),
            Obx(() {
              return Text(
                '${controller.currentQuestionIndex.value + 1}/${controller.questions.length}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16), // Texto del medidor de preguntas
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
                    color:
                        Colors.white, // Fondo blanco para la caja de la pregunta
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    question['pregunta'],
                    style: TextStyle(
                        fontSize: 20), // Tamaño de la letra de la pregunta
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                ...options.entries.map((entry) {
                  final isSelected = controller.selectedOption.value == entry.key;
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
                        backgroundColor:
                            color, // Fondo verde o rojo si está seleccionada, blanco si no lo está
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors
                                .black), // Tamaño de la letra de las opciones
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }).toList(),
                SizedBox(height: 20),
                Text(
                  'Tiempo restante: ${controller.timeLeft.value} segundos',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // Texto del temporizador en blanco
                  ),
                  textAlign: TextAlign.center,
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
