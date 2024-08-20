import 'package:educode/interfaces/pages/login_register/recuperar_contra.dart';

import 'package:educode/interfaces/pages/topic_pages/mixto_page.dart';

import 'package:educode/mode_page.dart';
import 'package:educode/interfaces/pages/game_mode/multijugador_page.dart';
import 'package:educode/interfaces/pages/game_mode/solitario_page.dart';
import 'package:educode/interfaces/pages/login_register/inicio.dart';
import 'package:educode/interfaces/pages/login_register/login_page.dart';
import 'package:educode/interfaces/pages/login_register/registro_page.dart';
import 'package:educode/interfaces/pages/topic_pages/algoritmo_page.dart';
import 'package:educode/interfaces/pages/topic_pages/basedatos_page.dart';
import 'package:educode/interfaces/pages/topic_pages/lenguaje_programacion_page.dart';
import 'package:educode/interfaces/pages/topic_pages/programacion_page.dart';
import 'package:educode/interfaces/pages/topic_pages/POO_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:educode/controllers/user_controller.dart';

// Importa HomeMultiPage y WheelPage
import 'package:educode/interfaces/pages/home/widgets/wheel_page.dart';
import 'package:educode/interfaces/pages/home/home_page_multi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Inicializa GetStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/', page: () => const Inicio()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/registro', page: () => RegistroPage()),
        GetPage(name: '/home', page: () => ModePage()),
        GetPage(name: '/solitario', page: () => SolitarioPage()),
        GetPage(name: '/multijugador', page: () => MultijugadorPage()),
        GetPage(name: '/basedatos', page: () => BasedatosPage()),
        GetPage(name: '/programacion', page: () => ProgramacionPage()),
        GetPage(name: '/poo', page: () => POOPage()),
        GetPage(
            name: '/lenguaje_programacion',
            page: () => LenguajeProgramacionPage()),
        GetPage(name: '/algoritmo', page: () => AlgoritmoPage()),
        GetPage(name: '/password', page: () => ForgetPasswordPage()),
        // Rutas para HomeMultiPage y WheelPage
        GetPage(name: '/home_multi', page: () => HomeMultiPage()),
        GetPage(
            name: '/wheel',
            page: () => WheelPage(
                  player1Name:
                      'Jugador 1', // Valores predeterminados, puedes cambiar esto según tu lógica
                  player1Icon: Icons.person,
                  player2Name: 'Jugador 2',
                  player2Icon: Icons.person_outline,
                )),
      ],
    );
  }
}
