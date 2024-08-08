import 'package:educode/interfaces/pages/home/home_page.dart';
import 'package:educode/interfaces/pages/settings/account_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SolitarioPage extends StatefulWidget {
  @override
  _SolitarioPageState createState() => _SolitarioPageState();
}

class _SolitarioPageState extends State<SolitarioPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(), // Página de inicio con los botones
    Text('Historia',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 5) {
          // Ajusta este valor para cambiar la sensibilidad
          Get.back();
        }
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Solitario'),
        // ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.purple[300],
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historia',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

