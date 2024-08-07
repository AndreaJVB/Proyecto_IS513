import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SolitarioPage extends StatefulWidget {
  @override
  _SolitarioPageState createState() => _SolitarioPageState();
}

class _SolitarioPageState extends State<SolitarioPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    InicioPage(), // Página de inicio con los botones
    Text('Historia',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Settings',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () => Get.toNamed('/basedatos'),
              child: Text('Basedatos', style: TextStyle(fontSize: 24)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () => Get.toNamed('/programacion1'),
              child: Text('Programacion 1', style: TextStyle(fontSize: 24)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () => Get.toNamed('/programacion2'),
              child: Text('Programacion 2', style: TextStyle(fontSize: 24)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () => Get.toNamed('/lenguaje_programacion'),
              child: Text('Lenguaje de Programación',
                  style: TextStyle(fontSize: 24)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () => Get.toNamed('/algoritmo'),
              child: Text('Algoritmo', style: TextStyle(fontSize: 24)),
            ),
          ),
        ],
      ),
    );
  }
}
