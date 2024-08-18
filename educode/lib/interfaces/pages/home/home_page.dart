import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/home/widgets/boton_categoria_mixta.dart';
import 'package:educode/interfaces/pages/home/widgets/botones_categoria.dart';
import 'package:educode/interfaces/pages/home/widgets/escoger_categoria.dart';
import 'package:educode/interfaces/pages/login_register/widgets/screen_theme.dart';
import 'package:educode/interfaces/pages/results_poo.dart/mixto_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.getUser});
  final UserController getUser;

  @override
  Widget build(BuildContext context) {
    final screenP = ScreenProperty(
        context: context); // Asegúrate de que esta clase esté bien definida

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3A1C71),
        automaticallyImplyLeading: false,
        toolbarHeight: screenP.altura * 0.25,
        flexibleSpace: Obx(() => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("lib/assets/fondo.jpg"),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          NetworkImage(getUser.user.value?.photoURL ?? ""),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hola,",
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${getUser.user.value?.displayName ?? 'Nombre no disponible'}",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5F2C82), Color(0xFF49A09D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Table(
                  children: [
                    TableRow(
                      children: [
                        CategoriaBoton(
                          nombre: "/basedatos",
                          icono: Icons.storage,
                          texto: 'Base de Datos',
                        ),
                        CategoriaBoton(
                            nombre: '/programacion',
                            icono: Icons.computer,
                            texto: 'Programación'),
                      ],
                    ),
                    TableRow(
                      children: [
                        CategoriaBoton(
                            nombre: '/poo', icono: Icons.code, texto: 'POO'),
                        CategoriaBoton(
                            nombre: '/algoritmo',
                            icono: Icons.functions,
                            texto: 'Algoritmo')
                      ],
                    ),
                    TableRow(
                      children: [
                        CategoriaBoton(
                    nombre: '/lenguaje_programacion',
                    icono: Icons.flutter_dash,
                    texto: 'Lenguaje de Programación'),
                
                    BotonCategoriaMixta()
                      ]
                    )
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
