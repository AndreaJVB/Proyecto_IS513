import 'dart:convert';
import 'package:flutter/material.dart';
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
  var gameEnded = false.obs;

  final Map<String, String> urls = {
    'Algoritmo': 'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/algoritmo.json',
    'Base de Datos': 'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/basedatos.json',
    'Flutter': 'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/flutter.json',
    'POO': 'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/Programacion%20Orienta%20a%20Objeto.json',
    'Programación': 'https://raw.githubusercontent.com/Chrisherndz/educode_quizz/main/programacion.json',
  };

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

  void getRandomQuestion() {
    if (questions.isNotEmpty) {
      final randomIndex = (questions.length *
              (DateTime.now().millisecondsSinceEpoch % 1000) ~/
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

  void checkAnswer(String answer, String nombre1, String nombre2) {
    if (gameEnded.value) return; // Salir si el juego ya terminó

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
    // if (player1Stars.value == 5 || player2Stars.value == 5) {
    //   gameEnded.value = true;
    //   showGanadorDialog(nombre1);
    // } 
     if (currentRound.value < totalRounds) {
      currentPlayer.value = currentPlayer.value == 1 ? 2 : 1;
      currentRound.value += 1;
      _showTurnNotification();
      getRandomQuestion();
    } else {
       determineWinner(nombre1, nombre2);
      gameEnded.value = true;
     
    }
  }

  void determineWinner(String nombre1, String nombre2) {
    String winner;
    if (player1Stars.value == 5) {
      winner = '¡Jugador 1 Gana!';
      showGanadorDialog(nombre1);
    } else if (player2Stars.value == 5) {
      winner = '¡Jugador 2 Gana!';
      showGanadorDialog(nombre2);
    } else {
      winner = '¡Es un empate!';
      showGanadorDialog(nombre1); // Puedes decidir a quién mostrar, en este caso nombre1
    }
    Get.snackbar('Resultado', winner,
        snackPosition: SnackPosition.TOP, duration: Duration(seconds: 3));
  }

  void showGanadorDialog(String nombre) {
    Get.defaultDialog(
      title: 'GANADOR',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("GANADOR: ${nombre}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Get.back(); // Cambia esta ruta si es necesario
          },
          child: Text("VOLVER AL INICIO"),
        ),
      ],
    );
  }

  void _showTurnNotification() {
    Get.snackbar(
      'Turno de Jugador ${currentPlayer.value}',
      '¡Prepárate para responder!',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }
}
