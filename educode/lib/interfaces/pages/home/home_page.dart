import 'package:educode/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final UserController getUser = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Obx(() {
            final user = getUser.user.value?.displayName;
           
            return FittedBox(child: Text("Bienvenido $user"));
          }),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed('/basedatos'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.storage, size: 24),
                            Text('Basedatos', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed('/programacion1'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.computer, size: 24),
                            Text('Programacion 1',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed('/programacion2'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.code, size: 24),
                            Text('Programacion 2',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed('/algoritmo'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.functions, size: 24),
                            Text('Algoritmo', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/lenguaje_programacion'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                ),
                child: Column(
                  children: [
                    Icon(Icons.language, size: 24),
                    Text('Lenguaje de Programación',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
