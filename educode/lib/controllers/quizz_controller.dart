import 'package:educode/interfaces/pages/results_poo.dart/results_basedatos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:get/get.dart';


class QuizController extends GetxController {

  QuizController({required this.url, required this.data1, required this.topic});

  final String url;
  final String data1;
  final String topic;

  var questions = <dynamic>[].obs;
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var timeLeft = 30.obs;
  var selectedOption = ''.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        questions.assignAll(data[data1]);
        questions.shuffle(); // Aleatorizar el orden de las preguntas
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
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer?.cancel();
        timeOut(); // Si se acaba el tiempo sin seleccionar ninguna opción
      }
    });
  }

  void answerQuestion(String selectedOption) {
    if (this.selectedOption.isEmpty) {
      timer?.cancel();
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
              ResultsBasedatos(score: score.value, total: questions.length, topic: topic,));
        }
      });
    }
  }

  void timeOut() {
    // Si el tiempo se acaba y no se ha seleccionado opción, avanza como incorrecta
    if (selectedOption.isEmpty) {
      if (currentQuestionIndex.value < questions.length - 1) {
        _nextQuestion();
      } else {
        Get.to(() =>
            ResultsBasedatos(score: score.value, total: questions.length, topic: topic,));
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
    timer?.cancel();
    super.onClose();
  }
}