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
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 5) {
          // Ajusta este valor para cambiar la sensibilidad
          Get.back();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Solitario'),
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

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Table(
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed('/basedatos'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.storage, size: 24),
                          Text('Basedatos', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed('/programacion1'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.computer, size: 24),
                          Text('Programacion 1',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed('/programacion2'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.code, size: 24),
                          Text('Programacion 2',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed('/algoritmo'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.functions, size: 24),
                          Text('Algoritmo', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              onPressed: () => Get.toNamed('/lenguaje_programacion'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              ),
              child: Column(
                children: [
                  Icon(Icons.language, size: 24),
                  Text('Lenguaje de Programación',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
