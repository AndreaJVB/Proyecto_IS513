import 'package:educode/mode_page.dart';
import 'package:educode/interfaces/pages/game_mode/multijugador_page.dart';
import 'package:educode/interfaces/pages/game_mode/solitario_page.dart';
import 'package:educode/interfaces/pages/login_register/inicio.dart';
import 'package:educode/interfaces/pages/login_register/login_page.dart';
import 'package:educode/interfaces/pages/login_register/registro_page.dart';
import 'package:educode/interfaces/pages/settings/account_page.dart';
import 'package:educode/interfaces/pages/topic_pages/algoritmo_page.dart';
import 'package:educode/interfaces/pages/topic_pages/basedatos_page.dart';
import 'package:educode/interfaces/pages/topic_pages/lenguaje_programaicon_page.dart';
import 'package:educode/interfaces/pages/topic_pages/programacion1_page.dart';
import 'package:educode/interfaces/pages/topic_pages/programacion2_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Inicio()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/registro', page: () => RegistroPage()),
        GetPage(name: '/home', page: () => const ModePage()),
        GetPage(name: '/solitario', page: () => SolitarioPage()),
        GetPage(name: '/multijugador', page: () => MultijugadorPage()),
        GetPage(name: '/basedatos', page: () => BasedatosPage()),
        GetPage(name: '/programacion1', page: () => Programacion1Page()),
        GetPage(name: '/programacion2', page: () => Programacion2Page()),
        GetPage(name: '/lenguaje_programacion', page: () => LenguajePage()),
        GetPage(name: '/algoritmo', page: () => AlgoritmoPage()),
      ],
    );
  }
}
