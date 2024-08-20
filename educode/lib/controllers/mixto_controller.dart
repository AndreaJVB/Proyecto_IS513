import 'package:educode/interfaces/pages/topic_pages/results_basedatos.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MixtoController extends GetxController {
  MixtoController({required this.map});

  final Map<String, List<String>> map;

  var tema = ''.obs;
  var questions = <dynamic>[].obs;
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var timeLeft = 30.obs;
  var selectedOption = ''.obs;
  var isLoading = true.obs; // Estado de carga
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    try {
      for (var entry in map.entries) {
        final response = await http.get(Uri.parse(entry.value[0]));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          for (var question in data[entry.value[1]]) {
            question['tema'] = entry.key; // Asigna el tema a cada pregunta
            questions.add(question);
          }
        } else {
          throw Exception('Error al cargar preguntas');
        }
      }

      questions.shuffle();
      if (questions.length > 20) {
        questions =
            questions.sublist(0, 20).obs; // Selecciona 20 preguntas al azar
      }

      if (questions.isNotEmpty) {
        tema.value = questions[currentQuestionIndex.value]['tema'];
      }
      isLoading.value = false; // Marca como cargado
      _startTimer();
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
        timer.cancel();
        timeOut();
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

      Future.delayed(Duration(seconds: 1), () {
        if (currentQuestionIndex.value < questions.length - 1) {
          _nextQuestion();
        } else {
          Get.to(() => ResultsBasedatos(
              score: score.value, total: questions.length, topic: 'Mixto'));
        }
      });
    }
  }

  void timeOut() {
    if (selectedOption.isEmpty) {
      if (currentQuestionIndex.value < questions.length - 1) {
        _nextQuestion();
      } else {
        Get.to(() => ResultsBasedatos(
            score: score.value, total: questions.length, topic: 'Mixto'));
      }
    }
  }

  void _nextQuestion() {
    currentQuestionIndex.value++;
    selectedOption.value = '';
    tema.value = questions[currentQuestionIndex.value]
        ['tema']; // Actualiza el tema para la siguiente pregunta
    _startTimer();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
