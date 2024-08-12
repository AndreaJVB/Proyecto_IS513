import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';
import 'results_algoritmo.dart'; // Importa la página de resultados

class AlgoritmoController extends GetxController {
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
        'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/algoritmo.json';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        questions.assignAll(data['algoritmo']);
        _startTimer();
      } else {
        throw Exception('Eror al cargar preguntas');
      }
    } catch (error) {
      print('Error cargando preguntass: $error');
    }
  }

  void _startTimer() {
    timeLeft.value = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        _timer?.cancel();
        _nextQuestion();
      }
    });
  }

  void _answerQuestion(String selectedOption) {
    _timer?.cancel();
    if (selectedOption ==
        questions[currentQuestionIndex.value]['respuesta_marcada']) {
      score++;
    }
    this.selectedOption.value = selectedOption;
    Future.delayed(Duration(seconds: 1), () => _nextQuestion());
  }

  void _nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      selectedOption.value = '';
      _startTimer();
    } else {
      Get.to(
          () => ResultsAlgoritmo(score: score.value, total: questions.length));
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

class AlgoritmoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AlgoritmoController controller = Get.put(AlgoritmoController());

    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: Obx(() => Text(
            'Educode - Pregunta ${controller.currentQuestionIndex.value + 1}')),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question['pregunta'],
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ...options.entries.map((entry) {
                final isSelected = controller.selectedOption.value == entry.key;
                final isCorrect = entry.key == question['respuesta_marcada'];
                final color = isSelected
                    ? (isCorrect ? Colors.green : Colors.red)
                    : Colors.white;

                return ElevatedButton(
                  onPressed: () => controller._answerQuestion(entry.key),
                  child: Text(entry.value),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              Text(
                'Tiempo restante: ${controller.timeLeft.value} segundos',
                style: TextStyle(
                    fontSize: 18, color: const Color.fromARGB(255, 26, 7, 6)),
              ),
            ],
          ),
        );
      }),
    );
  }
}
