import 'package:educode/controllers/historial_controller.dart';
import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/home/widgets/boton_categoria_mixta.dart';
import 'package:educode/interfaces/pages/login_register/widgets/screen_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.getUser});
  final UserController getUser;

  @override
  Widget build(BuildContext context) {
    final HistorialController getUserName = HistorialController();
    final screenP = ScreenProperty(context: context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A1C71),
        automaticallyImplyLeading: false,
        toolbarHeight: screenP.altura * 0.25,
        flexibleSpace: Obx(() => Container(
              decoration: const BoxDecoration(
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Hola,",
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          FutureBuilder<String>(
                            future: getUserName
                                .getNombreUsuario(getUser.user.value),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text(
                                  "Cargando...",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return const Text(
                                  "Error al cargar nombre",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                return Text(
                                  snapshot.data ?? 'Nombre no disponible',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                );
                              }
                            },
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
        decoration: const BoxDecoration(
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
                        CategoriaBotonConImagen(
                          nombre: "/basedatos",
                          imagePath: 'lib/assets/basedatos.png',
                          texto: 'Base de Datos',
                        ),
                        CategoriaBotonConImagen(
                          nombre: '/programacion',
                          imagePath: 'lib/assets/programacion.png',
                          texto: 'Programación',
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        CategoriaBotonConImagen(
                          nombre: '/poo',
                          imagePath: 'lib/assets/poo.png',
                          texto: 'POO',
                        ),
                        CategoriaBotonConImagen(
                          nombre: '/algoritmo',
                          imagePath: 'lib/assets/algoritmo.png',
                          texto: 'Algoritmo',
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        CategoriaBotonConImagen(
                          nombre: '/lenguaje_programacion',
                          imagePath: 'lib/assets/flutter.png',
                          texto: 'Lenguaje de Programación',
                          textAlign: TextAlign.center,
                        ),
                        BotonCategoriaMixta(),
                      ],
                    ),
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

class CategoriaBotonConImagen extends StatelessWidget {
  final String nombre;
  final String imagePath;
  final String texto;
  final TextAlign textAlign;

  const CategoriaBotonConImagen({
    required this.nombre,
    required this.imagePath,
    required this.texto,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offAllNamed(nombre);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 8.0),
            Text(
              texto,
              textAlign: textAlign,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}