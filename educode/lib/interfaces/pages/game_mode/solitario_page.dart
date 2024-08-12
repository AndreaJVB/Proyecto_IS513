import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/home/home_page.dart';
import 'package:educode/interfaces/pages/settings/account_page.dart';
import 'package:educode/interfaces/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SolitarioPage extends StatelessWidget {
  final UserController getUser = Get.find<UserController>();
  final _navigation = <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ];

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text('Historia', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });

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
        bottomNavigationBar: BottomNavigationBarCustom(indexs: getUser.selectedIndex, itemsBar: _navigation,),
      ),
    );
  }
}