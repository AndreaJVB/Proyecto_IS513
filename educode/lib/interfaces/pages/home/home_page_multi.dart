import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/home/widgets/wheel_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMultiPage extends StatelessWidget {
  HomeMultiPage({
    super.key,
    required this.getUser,
  });

  final UserController getUser;
  final controller = Get.put<MultijugadorController>(MultijugadorController());
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: controller.player1Controller,
              decoration: InputDecoration(labelText: 'Nombre del Jugador 1'),
              validator: (value) {
                if (value == null || value.length < 5) {
                  return 'El nombre debe tener al menos 5 caracteres';
                }
                return null;
              },
            ),
            Obx(() => DropdownButton<String>(
                  value: controller.avatarPlayer1.value,
                  onChanged: (String? newValue) {
                    controller.avatarPlayer1.value = newValue!;
                  },
                  items: controller.avatars
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                      .toList(),
                )),
            TextFormField(
              controller: controller.player2Controller,
              decoration: InputDecoration(labelText: 'Nombre del Jugador 2'),
              validator: (value) {
                if (value == null || value.length < 5) {
                  return 'El nombre debe tener al menos 5 caracteres';
                }
                return null;
              },
            ),
            Obx(() => DropdownButton<String>(
                  value: controller.avatarPlayer2.value,
                  onChanged: (String? newValue) {
                    controller.avatarPlayer2.value = newValue!;
                  },
                  items: controller.avatars
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                      .toList(),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.startGame,
              child: Text('Comenzar Juego'),
            ),
          ],
        ),
      ),
    );
  }
}

class MultijugadorController extends GetxController {
  final player1Controller = TextEditingController();
  final player2Controller = TextEditingController();
  var avatarPlayer1 = 'Avatar1'.obs;
  var avatarPlayer2 = 'Avatar2'.obs;
  final List<String> avatars = ['Avatar1', 'Avatar2', 'Avatar3'];
  final UserController getUser = Get.find<UserController>();

  void startGame() {
    if (Get.find<MultijugadorController>().formKey.currentState!.validate()) {
      Get.to(() => WheelPage());
    }
  }

  final formKey = GlobalKey<FormState>();
}