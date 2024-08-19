import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuizzControllerMultijugador extends GetxController {
  var questions = [].obs;
  var currentQuestion = ''.obs;
  var currentOptions = <String>[].obs;
  var correctAnswer = ''.obs;
  var player1Stars = 0.obs;
  var player2Stars = 0.obs;
  var currentPlayer = 1.obs;
  var currentRound = 1.obs;
  final int totalRounds = 10;

  // URLs de los archivos JSON para cada tema
  final Map<String, String> urls = {
    'Algoritmo':
        'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/algoritmo.json',
    'Base de Datos':
        'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/basedatos.json',
    'Flutter':
        'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/flutter.json',
    'POO':
        'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/Programacion%20Orienta%20a%20Objeto.json',
    'Programación':
        'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/programacion.json',
  };

  // Método para cargar las preguntas según el tema
  Future<void> loadQuestions(String topic) async {
    final url = urls[topic];
    if (url != null) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data.isNotEmpty) {
          String firstKey = data.keys.first;
          questions.value = data[firstKey];
          getRandomQuestion();
        } else {
          print('Error: Datos o preguntas no válidas');
        }
      } else {
        print('Error al cargar las preguntas: ${response.statusCode}');
      }
    } else {
      print('URL no válida para el tema $topic');
    }
  }

  // Método para obtener una pregunta aleatoria
  void getRandomQuestion() {
    if (questions.isNotEmpty) {
      final randomIndex = (questions.length *
              (new DateTime.now().millisecondsSinceEpoch % 1000) ~/
              1000) %
          questions.length;
      final questionData = questions[randomIndex];
      currentQuestion.value = questionData['pregunta'];
      final optionsMap = questionData['opciones'] as Map<String, dynamic>;
      currentOptions.value =
          optionsMap.values.map((option) => option.toString()).toList();
      correctAnswer.value = questionData['respuesta_marcada'].toString();
    }
  }

  // Método para verificar la respuesta y actualizar las estrellas
  void checkAnswer(String answer) {
    if (answer == correctAnswer.value) {
      // Respuesta correcta: sumar una estrella
      if (currentPlayer.value == 1 && player1Stars.value < 5) {
        player1Stars.value += 1;
      } else if (currentPlayer.value == 2 && player2Stars.value < 5) {
        player2Stars.value += 1;
      }
    } else {
      // Respuesta incorrecta: restar una estrella si tiene alguna
      if (currentPlayer.value == 1 && player1Stars.value > 0) {
        player1Stars.value -= 1;
      } else if (currentPlayer.value == 2 && player2Stars.value > 0) {
        player2Stars.value -= 1;
      }
    }

    // Verificar si alguno ha ganado
    if (player1Stars.value == 5 || player2Stars.value == 5) {
      determineWinner();
    } else if (currentRound.value < totalRounds) {
      // Avanzar a la siguiente ronda si aún no se ha alcanzado el total de rondas
      currentRound.value += 1;
      currentPlayer.value = currentPlayer.value == 1 ? 2 : 1;
      _showTurnNotification();
      getRandomQuestion();
    }
  }

  // Método para determinar el ganador y finalizar el juego
  void determineWinner() {
    String winner = '';
    if (player1Stars.value == 5) {
      winner = 'Jugador 1';
    } else if (player2Stars.value == 5) {
      winner = 'Jugador 2';
    }

    currentQuestion.value = '¡Ganaste! Felicidades $winner';

    // Redirigir a la pantalla de ingreso de datos después de 3 segundos
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(
          '/home_multi'); // Cambia '/home_multi' por la ruta de tu pantalla de ingreso de datos si es diferente
    });
  }

  // Método para mostrar la notificación del turno
  void _showTurnNotification() {
    String playerName = currentPlayer.value == 1 ? 'Jugador 1' : 'Jugador 2';
    Get.snackbar('Turno del Jugador', 'Turno del jugador: $playerName',
        snackPosition: SnackPosition.BOTTOM);
  }
}
