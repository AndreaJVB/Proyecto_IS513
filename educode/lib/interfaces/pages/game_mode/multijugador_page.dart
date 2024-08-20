import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/home/home_page_multi.dart';
import 'package:educode/interfaces/pages/settings/account_page.dart';
import 'package:educode/interfaces/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultijugadorPage extends StatelessWidget {
  final _navigation = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  final UserController getUser = Get.put<UserController>(UserController());

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      HomeMultiPage(),
      ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Multijugador'),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(
        indexs: getUser.selectedIndex,
        itemsBar: _navigation,
        onTap: (index) {
          getUser.selectedIndex.value = index;  // Cambiado a selectedIndexMulti
        },
      ),
      body: Obx(() {
        return Center(
          child: widgetOptions.elementAt(getUser.selectedIndex.value),
        );
      }),
    );
  }
}
