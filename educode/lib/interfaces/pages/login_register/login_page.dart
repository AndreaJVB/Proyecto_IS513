import 'package:educode/controllers/auth.dart';
import 'package:educode/interfaces/pages/login_register/widgets/botonesLRI_custom.dart';
import 'package:educode/interfaces/pages/login_register/widgets/icono_cerrar.dart';
import 'package:educode/interfaces/pages/login_register/widgets/screen_theme.dart';
import 'package:educode/interfaces/widgets/custom_textFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final correoControler = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenP = ScreenProperty(context: context);
     final Auth ingresarCuenta= Auth();
     //color
     Color? fillColor = Colors.grey[200];

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
                      Form(
                        child: Column(children: [
                          const SizedBox(height: 30),
                          TextFormCustom(
                            label: "Correo", 
                            controller: correoControler,
                            fillColor: fillColor,
                            prefixIcon: Icons.email,
                            ),
                            const SizedBox(height: 20),

                           TextFormCustom(
                            label: "Contraseña", 
                            controller: passwordController,
                            fillColor: fillColor,
                            prefixIcon: Icons.password_outlined,
                            obscureText: true,
                            )
                        ],)),
                      const SizedBox(height: 30),
                      OutlinedButtomInicio(
                        ancho: screenP.ancho,
                        size: Size(screenP.ancho * 0.8, 50),
                        texto: "Iniciar sesión",
                        funcion: () {
                            ingresarCuenta.signInWithEmailAndPassword(
                              email: correoControler.text, 
                              password: passwordController.text);    
                        },
                        color: const Color.fromARGB(61, 177, 139, 89),
                        elevation: 20,
                      ),
                      const SizedBox(height: 15),
                      const Text("--O--"),
                      const SizedBox(height: 15),
                      SignInButton(
                        Buttons.GoogleDark,
                        text: "Iniciar sesión con Google",
                        onPressed: () {
                          ingresarCuenta.handleGoogleSignIn();
                        },
                      ),
                      Align(child: TextButton(onPressed: (){
                        Get.toNamed('/password');
                      }, child: Text("Olvidaste la contraseña?"),),alignment: Alignment.bottomLeft,)
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