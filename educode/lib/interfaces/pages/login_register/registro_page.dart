import 'package:educode/controllers/auth.dart';
import 'package:educode/controllers/validaciones.dart';
import 'package:educode/interfaces/pages/login_register/widgets/icono_cerrar.dart';
import 'package:educode/interfaces/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:educode/interfaces/pages/login_register/widgets/botonesLRI_custom.dart';
import 'package:educode/interfaces/pages/login_register/widgets/screen_theme.dart';
import 'package:educode/interfaces/widgets/custom_textFormField.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegistroPage extends StatelessWidget {
  RegistroPage({super.key});

  //Controllers
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final usuarioController = TextEditingController();
  final correoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final Auth createUsers = Auth();

  @override
  Widget build(BuildContext context) {
    //Variables
    final screenP = ScreenProperty(context: context);
    final validar = Validacion();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenP.altura,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: screenP.altura * 0.30,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: CircleAvatarCustom(), //AVATAR
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: screenP.altura * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(     
                      children: [
                        Wrap(
                          runSpacing: 12,
                          children: [
                            TextFormCustom(label: "Nombre", controller: nombreController),
                            TextFormCustom(label: "Apellido", controller: apellidoController),
                            TextFormCustom(label: "Nombre Usuario", controller: usuarioController),
                            TextFormCustom(label: "Correo", 
                            controller: correoController, keyboardType: TextInputType.emailAddress,
                            validator: (valor){
                              validar.validacionCorreo(correoController);
                            },
                            ),
                            TextFormCustom(label: "Contraseña", controller: passwordController, obscureText: true),
                            TextFormCustom(label: "Confirmar Contraseña", controller: confirmPassword, obscureText: true),
                          ],
                        ),
                        SizedBox(height: 20),
                        OutlinedButtomInicio(
                          ancho: screenP.ancho * 0.7,
                          texto: "Registrarse",
                          funcion: () {
                            if (!formkey.currentState!.validate()) return;
                            createUsers.createUserWithEmailAndPassword(
                              email: correoController.text,
                               password: passwordController.text);
                        
                          },
                          color: Colors.white,
                          textStyle: TextStyle(color: Color(0xFFFF5F6D), fontWeight: FontWeight.bold),
                          size: Size(screenP.ancho * 0.7, 50),
                          elevation: 5,
                        ),
                        SizedBox(height: 20),
                         SignInButton(
                        Buttons.GoogleDark,
                        text: "Registrarse con Google",
                        onPressed: () {},
                      ),
                      ],
                    ),
                  ),
                ),
              ),
              closeIcon()
            ],
          ),
        ),
      ),
    );
  }
}