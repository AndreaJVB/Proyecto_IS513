import 'package:educode/interfaces/pages/login_register/widgets/botonesLRI_custom.dart';
import 'package:educode/interfaces/pages/login_register/widgets/icono_cerrar.dart';
import 'package:educode/interfaces/pages/login_register/widgets/screen_theme.dart';
import 'package:educode/interfaces/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenP = ScreenProperty(context: context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: screenP.altura * 0.4,
                  decoration: BoxDecoration(
                    gradient: screenP.fondoGradiente(),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Registrarse',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFieldCustom(
                        hintText: "Correo Electrónico",
                        fillColor: Colors.grey[200],
                        prefixIcono: Icons.email,
                      ),
                      const SizedBox(height: 20),
                      TextFieldCustom(
                        hintText: "Contraseña",
                        fillColor: Colors.grey[200],
                        obscureText: true,
                        prefixIcono: Icons.lock,
                      ),
                      const SizedBox(height: 30),
                      OutlinedButtomInicio(
                        ancho: screenP.ancho,
                        size: Size(screenP.ancho * 0.8, 50),
                        texto: "Iniciar sesión",
                        funcion: () {Get.toNamed('/perfil');},
                        color: const Color.fromARGB(61, 177, 139, 89),
                        elevation: 20,
                      ),
                      const SizedBox(height: 15),
                      const Text("--O--"),
                      const SizedBox(height: 15),
                      SignInButton(
                        Buttons.GoogleDark,
                        text: "Iniciar sesión con Google",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          closeIcon(), //Widget del icono cerrar
        ],
      ),
    );
  }
}