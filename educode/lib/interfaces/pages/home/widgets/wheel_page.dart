import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:educode/controllers/quizz_controller_multijugador.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WheelPage extends StatefulWidget {
  final String player1Name;
  final IconData player1Icon;
  final String player2Name;
  final IconData player2Icon;
  final topicsInfo;
  final List<String> topics;

  WheelPage({
    required this.player1Name,
    required this.player1Icon,
    required this.player2Name,
    required this.player2Icon,
    required this.topics,
    required this.topicsInfo
  });

  @override
  _WheelPageState createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  final StreamController<int> selected = StreamController<int>();
  int selectedIndex = 0;
  int previousIndex = -1;

  final quizzController = Get.put(QuizzControllerMultijugador());

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  void _selectNewIndex() {
    // Selecciona un índice aleatorio válido
    setState(() {
      do {
        selectedIndex = Fortune.randomInt(0, widget.topics.length);
      } while (selectedIndex == previousIndex);
      previousIndex = selectedIndex;
    });
  }

  void _showTopicSelectionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Bloquea la acción de retroceso
          child: AlertDialog(
            backgroundColor: Colors.grey[200], // Color neutro
            title: Text(
              "Selecciona un tema",
              style: TextStyle(color: Colors.black),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.topics.sublist(0, widget.topics.length - 1).map((topic) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _loadSelectedTopic(topic);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 61, 121, 250),
                      foregroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      topic,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                child: Text("Cancelar", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _loadSelectedTopic(String topic) {
    quizzController.loadQuestions(topic).then((_) {
      if (quizzController.currentQuestion.value.isNotEmpty) {
        _showQuestionDialog();
      } else {
        print('No se pudo cargar la pregunta para el tema $topic');
      }
    });
  }

  void _showQuestionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Bloquea la acción de retroceso
          child: AlertDialog(
            backgroundColor: Colors.grey[200], // Color neutro
            title: Text("Pregunta", style: TextStyle(color: Colors.black)),
            content: Obx(() {
              if (quizzController.currentQuestion.value.isEmpty ||
                  quizzController.currentOptions.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                final optionLetters = ['a', 'b', 'c', 'd'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      quizzController.currentQuestion.value,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    ...List.generate(quizzController.currentOptions.length,
                        (index) {
                      final letter = optionLetters[index];
                      final option = quizzController.currentOptions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            quizzController.checkAnswer(
                                letter, widget.player1Name, widget.player2Name);
                            Navigator.of(context).pop();
                            
                            if(quizzController.player1Stars.value == 5 || quizzController.player2Stars.value == 5){
                              if(quizzController.player1Stars.value == 5){
                                quizzController.showGanadorDialog("EL GANADOR ES ${widget.player1Name}");
                              }else{
                               quizzController.showGanadorDialog("EL GANADOR ES ${widget.player2Name}");
                              }
                            } else if(quizzController.currentRound.value == 10){
                                quizzController.showGanadorDialog("NINGUNO GANO ES UN EMPATE");
                            }
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
      backgroundColor: Colors.grey[300], // Fondo neutro
      appBar: AppBar(
        backgroundColor: Colors.grey[700], // Fondo AppBar
        title: Text(
          'Rueda de Temas',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Sección de jugadores
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPlayerInfo(widget.player1Icon, widget.player1Name,
                  quizzController.player1Stars),
              Text(
                'VS',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              _buildPlayerInfo(widget.player2Icon, widget.player2Name,
                  quizzController.player2Stars),
            ],
          ),
          SizedBox(height: 20),
          // Sección de la rueda
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Obx(() {
                    return Text("Turno del jugador ${quizzController.currentPlayer.value}");
                  }),
                ),
                FortuneWheel(
                  selected: selected.stream,
                  items: [
                    for (var topic in widget.topics)
                      FortuneItem(
                        child: topic == "Elige un tema"
                            ? FaIcon(FontAwesomeIcons.user,
                                size: 24, color: Colors.black)
                            : Text(
                                topic,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                      ),
                  ],
                  onAnimationEnd: () {
                    final selectedTopic = widget.topics[selectedIndex];
                    if (selectedTopic == "Elige un tema") {
                      _showTopicSelectionDialog();
                    } else {
                      _loadSelectedTopic(selectedTopic);
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () {
                _selectNewIndex();
                selected.add(selectedIndex); // Actualiza el índice en el stream
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700], // Color del botón
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(15), // Ajusta el padding para el icono
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Girar',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerInfo(IconData icon, String playerName, RxInt playerStars) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[800],
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(height: 10),
        Text(
          playerName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Obx(() => _buildStars(playerStars.value)),
      ],
    );
  }
}
