import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModePage extends StatelessWidget {
  const ModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Solitario', style: TextStyle(fontSize: 20)),
              leading: const Icon(Icons.menu),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Get.back(); // Cerrar el drawer
                Get.toNamed('/solitario');
              },
            ),
            ListTile(
              title: const Text('Multijugador', style: TextStyle(fontSize: 20)),
              leading: const Icon(Icons.menu),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Get.back(); // Cerrar el drawer
                Get.toNamed('/multijugador');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () => Get.toNamed('/solitario'),
                child: const Text('Solitario', style: TextStyle(fontSize: 24)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                onPressed: () => Get.toNamed('/multijugador'),
                child:
                    const Text('Multijugador', style: TextStyle(fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
