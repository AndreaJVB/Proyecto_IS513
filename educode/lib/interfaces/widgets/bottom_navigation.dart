import 'package:educode/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  const BottomNavigationBarCustom({
    super.key,
    required this.itemsBar,
    required this.indexs,
    required this.onTap, // Agregar el parámetro onTap
  });
  
  final RxInt indexs;
  final List<BottomNavigationBarItem> itemsBar;
  final Function(int) onTap; // Definir el tipo de onTap

  @override
  Widget build(BuildContext context) {
    
    return Obx(() {
      return BottomNavigationBar(
        backgroundColor: Colors.purple[300],
        items: itemsBar,
        currentIndex: indexs.value,
        selectedItemColor: Colors.black,
        onTap: (index) =>
            onTap(index), // Llamar a onTap cuando se selecciona un ítem
      );
    });
  }
}
