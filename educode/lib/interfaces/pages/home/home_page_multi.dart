import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/home/widgets/wheel_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMultiPage extends StatelessWidget {
  HomeMultiPage({
    super.key,
  });

  final getUser = Get.put<UserController>(UserController()) ;
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
            Obx(() => DropdownButton<IconData>(
                  value: controller.avatarPlayer1.value,
                  onChanged: (IconData? newValue) {
                    controller.avatarPlayer1.value = newValue!;
                  },
                  items: controller.avatars
                      .map<DropdownMenuItem<IconData>>(
                          (IconData value) => DropdownMenuItem<IconData>(
                                value: value,
                                child: Icon(value),
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
            Obx(() => DropdownButton<IconData>(
                  value: controller.avatarPlayer2.value,
                  onChanged: (IconData? newValue) {
                    controller.avatarPlayer2.value = newValue!;
                  },
                  items: controller.avatars
                      .map<DropdownMenuItem<IconData>>(
                          (IconData value) => DropdownMenuItem<IconData>(
                                value: value,
                                child: Icon(value),
                              ))
                      .toList(),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  Get.to(() => WheelPage(
                        player1Name: controller.player1Controller.text,
                        player1Icon: controller.avatarPlayer1.value,
                        player2Name: controller.player2Controller.text,
                        player2Icon: controller.avatarPlayer2.value,
                      ));
                }
              },
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

  final List<IconData> avatars = [
    Icons.person,
    Icons.person_outline,
    Icons.person_pin,
    Icons.person_add,
    Icons.face,
    Icons.tag_faces
  ];

  var avatarPlayer1 = Icons.person.obs;
  var avatarPlayer2 = Icons.face.obs;

  final UserController getUser = Get.find<UserController>();

  final formKey = GlobalKey<FormState>();
}
