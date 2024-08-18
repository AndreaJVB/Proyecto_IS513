import 'package:educode/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BotonRegresarHome extends StatelessWidget {
  const BotonRegresarHome({
    super.key,
    required this.userController,
  });
  
  final UserController userController;

  @override
  Widget build(BuildContext context) {
    final UserController getUser = Get.put<UserController>(UserController());
    return ElevatedButton(
      onPressed: () {
        Get.offNamed('/solitario');// Regresa a HomePage con el UserController
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Volver a Home',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}