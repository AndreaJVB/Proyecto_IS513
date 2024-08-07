import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultijugadorPage extends StatefulWidget {
  @override
  _MultijugadorPageState createState() => _MultijugadorPageState();
}

class _MultijugadorPageState extends State<MultijugadorPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Text('Inicio Multijugador',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Settings Multijugador',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
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
        appBar: AppBar(
          title: Text('Multijugador'),
        ),
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
