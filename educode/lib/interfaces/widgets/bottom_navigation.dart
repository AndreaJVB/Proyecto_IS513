import 'package:educode/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarCustom extends StatelessWidget {
  const BottomNavigationBarCustom({
    super.key,
    required this.itemsBar,
    required this.indexs,
  });

  final RxInt indexs;
  final List<BottomNavigationBarItem> itemsBar;

  @override
  Widget build(BuildContext context) {

    return Obx((){
      return BottomNavigationBar(
      backgroundColor: Colors.purple[300],
      items: itemsBar,
      currentIndex: indexs.value,
      selectedItemColor: Colors.black,
      onTap: (index) => indexs.value = index,
    );
    }
    );
    
  }
}
