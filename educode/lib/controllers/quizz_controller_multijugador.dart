import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuizzControllerMultijugador extends GetxController {
  final questions = [].obs;
  final currentQuestion = ''.obs;
  final currentOptions = <String>[].obs;
  final correctAnswer = ''.obs;
  final player1Stars = 0.obs;
  final player2Stars = 0.obs;
  final currentPlayer = 1.obs;
  final currentRound = 1.obs;
  final int totalRounds = 20;
  final gameEnded = false.obs;
  final selectedAnswer = ''.obs;

  final List<int> usedQuestions = []; // Lista para almacenar preguntas usadas
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

  Future<void> loadQuestions(String topic) async {
    final url = urls[topic];
    if (url != null) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data.isNotEmpty) {
          String firstKey = data.keys.first;
          questions.value = data[firstKey];
          usedQuestions.clear(); // Limpiar preguntas usadas al cargar nuevo tema
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
    if (questions.isNotEmpty && usedQuestions.length < questions.length) {
      int randomIndex;
      do {
        randomIndex = DateTime.now().millisecondsSinceEpoch % questions.length;
      } while (usedQuestions.contains(randomIndex));

      final questionData = questions[randomIndex];
      currentQuestion.value = questionData['pregunta'];
      final optionsMap = questionData['opciones'] as Map<String, dynamic>;
      currentOptions.value =
          optionsMap.values.map((option) => option.toString()).toList();
      correctAnswer.value = questionData['respuesta_marcada'].toString();

      usedQuestions.add(randomIndex); // Marcar pregunta como usada
    }
  }

    

  void checkAnswer(String answer, String nombre1, String nombre2) {
    if (gameEnded.value) return; // Salir si el juego ya terminó
    selectedAnswer.value = answer; // Actualizar la respuesta seleccionada
    
    print('Turno actual: Jugador ${currentPlayer.value}');
    print('Respuesta recibida: $answer');
    print('Respuesta correcta: ${correctAnswer.value}');

    if (answer == correctAnswer.value) {
      print('Respuesta correcta por Jugador ${currentPlayer.value}');
      if (currentPlayer.value == 1 && player1Stars.value < 5) {
        player1Stars.value += 1;
        print('Jugador 1 ahora tiene ${player1Stars.value} estrellas');
      } else if (currentPlayer.value == 2 && player2Stars.value < 5) {
        player2Stars.value += 1;
        print('Jugador 2 ahora tiene ${player2Stars.value} estrellas');
      }
    } else {
      print('Respuesta incorrecta por Jugador ${currentPlayer.value}');
      if (currentPlayer.value == 1 && player1Stars.value > 0) {
        player1Stars.value -= 1;
        print('Jugador 1 pierde una estrella, ahora tiene ${player1Stars.value}');
      } else if (currentPlayer.value == 2 && player2Stars.value > 0) {
        player2Stars.value -= 1;
        print('Jugador 2 pierde una estrella, ahora tiene ${player2Stars.value}');
      }
    }

    if (player1Stars.value == 5 || player2Stars.value == 5 || currentRound.value == totalRounds) {
      gameEnded.value = true;
      determineWinner(nombre1, nombre2);
    } else {
      currentPlayer.value = currentPlayer.value == 1 ? 2 : 1;
      currentRound.value += 1;
      print('Siguiente turno: Jugador ${currentPlayer.value}');
      _showTurnNotification();
      
    }
  }

  void determineWinner(String nombre1, String nombre2) {
    String winner;
    if (player1Stars.value == 5) {
      winner = '¡${nombre1} Gana!';
    } else if (player2Stars.value == 5) {
      winner = '¡${nombre2} Gana!';
    } else {
      winner = '¡Es un empate!';
    }
    
    Get.snackbar('Resultado', winner,
        snackPosition: SnackPosition.TOP, duration: Duration(seconds: 3));
  }

  void showGanadorDialog(String winnerMessage) {
    showDialog(
      context: Get.context!,
      barrierDismissible:
          false, // Evita que se cierre el diálogo al tocar fuera
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('GANADOR'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(winnerMessage,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Cierra el diálogo y regresa al inicio
              },
              child: Text("VOLVER AL INICIO"),
            ),
          ],
        );
      },
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

  void _showQuestionDialog(String nombre1, String nombre2) {
    showDialog(
      context: Get.context!,
      barrierDismissible:
          false, // Importante: evita que el diálogo se cierre al tocar fuera
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Bloquea la acción de retroceso
          child: AlertDialog(
            title: Text("Pregunta"),
            content: Obx(() {
              if (currentQuestion.value.isEmpty || currentOptions.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                final optionLetters = ['a', 'b', 'c', 'd'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      currentQuestion.value,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    ...List.generate(currentOptions.length, (index) {
                      final letter = optionLetters[index];
                      final option = currentOptions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            checkAnswer(letter, nombre1, nombre2);
                            Navigator.of(context)
                                .pop(); // Cierra el diálogo solo cuando se selecciona una opción
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '$letter. $option',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }
            }),
          ),
        );
      },
    );
  }
}
