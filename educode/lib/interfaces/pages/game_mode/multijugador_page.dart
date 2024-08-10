import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class MultijugadorPage extends StatefulWidget {
  @override
  _MultijugadorPageState createState() => _MultijugadorPageState();
}

class _MultijugadorPageState extends State<MultijugadorPage> {
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();
  String _avatarPlayer1 = 'Avatar1';
  String _avatarPlayer2 = 'Avatar2';
  final List<String> _avatars = ['Avatar1', 'Avatar2', 'Avatar3'];

  final _formKey = GlobalKey<FormState>();

  void _startGame() {
    if (_formKey.currentState!.validate()) {
      // Navigate to the wheel page
      Get.to(() => WheelPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multijugador'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _player1Controller,
                decoration: InputDecoration(labelText: 'Nombre del Jugador 1'),
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'El nombre debe tener al menos 5 caracteres';
                  }
                  return null;
                },
              ),
              DropdownButton<String>(
                value: _avatarPlayer1,
                onChanged: (String? newValue) {
                  setState(() {
                    _avatarPlayer1 = newValue!;
                  });
                },
                items: _avatars
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
              ),
              TextFormField(
                controller: _player2Controller,
                decoration: InputDecoration(labelText: 'Nombre del Jugador 2'),
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'El nombre debe tener al menos 5 caracteres';
                  }
                  return null;
                },
              ),
              DropdownButton<String>(
                value: _avatarPlayer2,
                onChanged: (String? newValue) {
                  setState(() {
                    _avatarPlayer2 = newValue!;
                  });
                },
                items: _avatars
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startGame,
                child: Text('Comenzar Juego'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WheelPage extends StatelessWidget {
  final List<String> topics = [
    "Base de datos",
    "Programación 1",
    "Programación 2",
    "Algoritmo",
    "Lenguaje de Programación"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rueda de Temas'),
      ),
      body: Center(
        child: FortuneWheel(
          items: [
            for (var topic in topics) FortuneItem(child: Text(topic)),
          ],
        ),
      ),
    );
  }
}
