import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/login_register/widgets/screen_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final UserController getUser = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final screenP = ScreenProperty(context: context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3A1C71),
        automaticallyImplyLeading: false, // Oculta la flecha de retroceso
        toolbarHeight: screenP.altura * 0.25,
        flexibleSpace: Container(
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
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
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
                      Flexible(
                        child: Text(
                          "${getUser.user.value!.displayName}",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
                        CategoriaBoton(nombre: "/basedatos", icono: Icons.storage, texto: 'Base de Datos',),
                        CategoriaBoton(nombre:'/programacion1' , icono: Icons.computer, texto: 'Programación'),
                      ],
                    ),
                    TableRow(
                      children: [
                        CategoriaBoton(nombre: '/poo', icono: Icons.code, texto: 'POO'),
                        CategoriaBoton(nombre: '/algoritmo', icono: Icons.functions, texto: 'Algoritmo')
                      ],
                    ),
                  ],
                ),
                CategoriaBoton(nombre: '/lenguaje_programacion', icono: Icons.language, texto: 'Lenguaje de Programación')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriaBoton extends StatelessWidget {
  const CategoriaBoton({
    super.key,
    required this.nombre,
    required this.icono,
    required this.texto
  });
  final String nombre;
  final IconData icono;
  final String texto;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () => Get.toNamed(nombre),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3A6073),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
        child: Column(
          children: [
            Icon(icono, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(texto, style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
