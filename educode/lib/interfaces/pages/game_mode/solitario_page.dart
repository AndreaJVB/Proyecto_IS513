import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/home/home_page.dart';
import 'package:educode/interfaces/pages/historial/history_page.dart'; // Asegúrate de que esta ruta es correcta
import 'package:educode/interfaces/pages/settings/account_page.dart';
import 'package:educode/interfaces/widgets/bottom_navigation.dart';

class SolitarioPage extends StatelessWidget {
  final _navigation = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  final UserController getUser = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      HomePage(getUser: getUser),
      HistorialPage(), // Asegúrate de que HistoryPage está correctamente importado y definido
      ProfilePage(),
    ];

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 5) {
          Get.back();
        }
      },
      child: Scaffold(
        body: Obx(() {
          return Center(
            child: _widgetOptions.elementAt(getUser.selectedIndex.value),
          );
        }),
        bottomNavigationBar: BottomNavigationBarCustom(
          indexs: getUser.selectedIndex,
          itemsBar: _navigation,
          onTap: (index) {
            getUser.selectedIndex.value = index;
          },
        ),
      ),
    );
  }
}
