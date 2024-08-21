import 'package:educode/interfaces/pages/home/widgets/boton_categoria_mixta.dart';
import 'package:educode/interfaces/pages/home/widgets/mixtas_multijugador.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/home/widgets/wheel_page.dart';

class HomeMultiPage extends StatelessWidget {
  HomeMultiPage({super.key, this.map });

  final getUser = Get.put<UserController>(UserController());
  final controller = Get.put<MultijugadorController>(MultijugadorController());
  final categorias = Get.put<BotonCategoriaMixtaMultijugador>(BotonCategoriaMixtaMultijugador());
  Map<String, List<String>>? map = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego Multijugador'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  categorias.build(context),
                  Text(
                    'Configura los Jugadores',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  
                  // Jugador 1
                  TextFormField(
                    controller: controller.player1Controller,
                    decoration: InputDecoration(
                      labelText: 'Nombre del Jugador 1',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'El nombre debe tener al menos 5 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Obx(() => DropdownButton<IconData>(
                        value: controller.avatarPlayer1.value,
                        onChanged: (IconData? newValue) {
                          controller.avatarPlayer1.value = newValue!;
                        },
                        items: controller.avatars
                            .map<DropdownMenuItem<IconData>>(
                                (IconData value) => DropdownMenuItem<IconData>(
                                      value: value,
                                      child: Icon(value, size: 30),
                                    ))
                            .toList(),
                        isExpanded: true,
                        iconSize: 30,
                        underline: SizedBox(),
                      )),
                  
                  SizedBox(height: 20),

                  // Jugador 2
                  TextFormField(
                    controller: controller.player2Controller,
                    decoration: InputDecoration(
                      labelText: 'Nombre del Jugador 2',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'El nombre debe tener al menos 5 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Obx(() => DropdownButton<IconData>(
                        value: controller.avatarPlayer2.value,
                        onChanged: (IconData? newValue) {
                          controller.avatarPlayer2.value = newValue!;
                        },
                        items: controller.avatars
                            .map<DropdownMenuItem<IconData>>(
                                (IconData value) => DropdownMenuItem<IconData>(
                                      value: value,
                                      child: Icon(value, size: 30),
                                    ))
                            .toList(),
                        isExpanded: true,
                        iconSize: 30,
                        underline: SizedBox(),
                      )),

                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      print(categorias.listaMostrar);
                      if (controller.formKey.currentState!.validate()) {
                        Get.to(() => WheelPage(
                              player1Name: controller.player1Controller.text,
                              player1Icon: controller.avatarPlayer1.value,
                              player2Name: controller.player2Controller.text,
                              player2Icon: controller.avatarPlayer2.value,
                              topics: categorias.listaMostrar,
                              topicsInfo: categorias.map.values,
                            ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Background color
                      foregroundColor: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Comenzar Juego',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

  final formKey = GlobalKey<FormState>();
}
