import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:educode/controllers/quizz_controller_multijugador.dart';

class WheelPage extends StatefulWidget {
  final String player1Name;
  final IconData player1Icon;
  final String player2Name;
  final IconData player2Icon;

  WheelPage({
    required this.player1Name,
    required this.player1Icon,
    required this.player2Name,
    required this.player2Icon,
  });

  @override
  _WheelPageState createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  final List<String> topics = [
    "Base de Datos",
    "Programación",
    "POO",
    "Algoritmo",
    "Flutter"
  ];

  StreamController<int> selected = StreamController<int>();
  int selectedIndex = 0;
  int previousIndex = -1;

  final quizzController = Get.put(QuizzControllerMultijugador());

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void _selectNewIndex() {
    do {
      selectedIndex = Fortune.randomInt(0, topics.length);
    } while (selectedIndex == previousIndex);
    previousIndex = selectedIndex;
  }

  void _showQuestionDialog() {
    Get.defaultDialog(
      title: "Pregunta",
      content: Obx(() {
        if (quizzController.currentQuestion.value.isEmpty ||
            quizzController.currentOptions.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          final optionLetters = ['a', 'b', 'c', 'd'];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quizzController.currentQuestion.value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ...List.generate(quizzController.currentOptions.length, (index) {
                final letter = optionLetters[index];
                final option = quizzController.currentOptions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      quizzController.checkAnswer(letter);
                      Navigator.of(context).pop();
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
    );
  }

  Widget _buildStars(int filledStars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < filledStars ? Icons.star : Icons.star_border,
          color: index < filledStars ? Colors.yellow : Colors.grey,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rueda de Temas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(widget.player1Icon, size: 40),
                    Text('P1: ${widget.player1Name}'),
                    Obx(() => _buildStars(quizzController.player1Stars.value)),
                  ],
                ),
                Text('VS',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Column(
                  children: [
                    Icon(widget.player2Icon, size: 40),
                    Text('P2: ${widget.player2Name}'),
                    Obx(() => _buildStars(quizzController.player2Stars.value)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FortuneWheel(
                    selected: selected.stream,
                    items: [
                      for (var topic in topics)
                        FortuneItem(
                          child: Text(
                            topic,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                    onAnimationEnd: () {
                      final selectedTopic = topics[selectedIndex];
                      quizzController.loadQuestions(selectedTopic).then((_) {
                        if (quizzController.currentQuestion.value.isNotEmpty) {
                          _showQuestionDialog();
                        } else {
                          print(
                              'No se pudo cargar la pregunta para el tema $selectedTopic');
                        }
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectNewIndex();
                      selected.add(selectedIndex);
                    },
                    child: Text('Girar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
