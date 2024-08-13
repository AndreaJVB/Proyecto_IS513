import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'results_programacion.dart';

class ProgramacionController extends GetxController {
  var questions = <dynamic>[].obs;
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var timeLeft = 30.obs;
  var selectedOption = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final url =
        'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/programacion.json';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        questions.assignAll(data['programacion']);
        questions.shuffle(); // Aleatorizar las preguntas
        _startTimer();
      } else {
        throw Exception('Error al cargar preguntas');
      }
    } catch (error) {
      print('Error cargando preguntas: $error');
    }
  }

  void _startTimer() {
    timeLeft.value = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        _timer?.cancel();
        _timeOut(); // Manejar el tiempo agotado
      }
    });
  }

  void _answerQuestion(String selectedOption) {
    if (this.selectedOption.isEmpty) {
      _timer?.cancel();
      if (selectedOption ==
          questions[currentQuestionIndex.value]['respuesta_marcada']) {
        score++;
      }
      this.selectedOption.value = selectedOption;

      // Esperar un segundo antes de pasar a la siguiente pregunta o mostrar resultados
      Future.delayed(Duration(seconds: 1), () {
        if (currentQuestionIndex.value < questions.length - 1) {
          _nextQuestion();
        } else {
          Get.to(() =>
              ResultsProgramacion(score: score.value, total: questions.length));
        }
      });
    }
  }

  void _timeOut() {
    if (selectedOption.isEmpty) {
      if (currentQuestionIndex.value < questions.length - 1) {
        _nextQuestion();
      } else {
        Get.to(() =>
            ResultsProgramacion(score: score.value, total: questions.length));
      }
    }
  }

  void _nextQuestion() {
    currentQuestionIndex.value++;
    selectedOption.value = '';
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

class ProgramacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProgramacionController controller = Get.put(ProgramacionController());

    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Text(
          'Programación',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center, // Centrar el título
        ),
      ),
      body: Obx(() {
        if (controller.questions.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        final question =
            controller.questions[controller.currentQuestionIndex.value];
        final options = question['opciones'] as Map<String, dynamic>;

        return Padding(
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
                final isSelected = controller.selectedOption.value == entry.key;
                final isCorrect = entry.key == question['respuesta_marcada'];
                final color = isSelected
                    ? (isCorrect ? Colors.green : Colors.red)
                    : Colors.white;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => controller._answerQuestion(entry.key),
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
              Text(
                'Tiempo restante: ${controller.timeLeft.value} segundos',
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }
}
