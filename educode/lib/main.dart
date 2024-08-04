import 'package:educode/interfaces/pages/login_register/inicio.dart';
import 'package:educode/interfaces/pages/login_register/login_page.dart';
import 'package:educode/interfaces/pages/login_register/registro_page.dart';
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

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () =>const Inicio(),),
        GetPage(name: '/login', page: ()=> LoginPage()),
        GetPage(name: '/registro', page: ()=> const RegistroPage())
      ],
    );
  }

}
