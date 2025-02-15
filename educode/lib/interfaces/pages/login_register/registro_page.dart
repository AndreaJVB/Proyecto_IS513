import 'package:educode/controllers/auth.dart';
import 'package:educode/controllers/validaciones.dart';
import 'package:educode/interfaces/pages/login_register/widgets/icono_cerrar.dart';
import 'package:educode/interfaces/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:educode/interfaces/pages/login_register/widgets/botonesLRI_custom.dart';
import 'package:educode/interfaces/pages/login_register/widgets/screen_theme.dart';
import 'package:educode/interfaces/widgets/custom_textFormField.dart';

class RegistroPage extends StatefulWidget {
  RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  // Controllers
  final nombreController = TextEditingController();

  final apellidoController = TextEditingController();

  final usuarioController = TextEditingController();

  final correoController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPassword = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final Auth createUsers = Auth();

 final avatar = CircleAvatarCustom();

 bool textoObscuro = true;
 bool textoObscuro2 = true;

  @override
  Widget build(BuildContext context) {
    // Variables
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
                child: Align(
                  alignment: Alignment.center,
                  child: avatar, // AVATAR
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
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Wrap(
                            runSpacing: 20,
                            children: [
                              TextFormCustom(
                                label: "Nombre",
                                controller: nombreController,
                                validator: (valor)=>validar.validacionNombre(valor),
                              ),
                              TextFormCustom(
                                label: "Apellido",
                                controller: apellidoController,
                                validator: (valor)=>validar.validacionApellido(valor),
                              ),
                              TextFormCustom(
                                label: "Nombre Usuario",
                                controller: usuarioController,
                                validator: (valor)=>validar.nombreUsuario(valor),
                              ),
                              TextFormCustom(
                                label: "Correo",
                                controller: correoController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (valor) {
                                  return validar.validacionCorreo(valor);
                                },
                              ),
                              TextFormCustom(
                                label: "Contraseña",
                                controller: passwordController,
                                obscureText: textoObscuro,
                                validator: (valor) {
                                  return validar.validacionPassword(valor);
                                },
                                suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), 
                                onPressed: (){
                                 
                                  setState(() {
                                     textoObscuro = !textoObscuro;
                                  });
                                },),
                              ),
                              TextFormCustom(
                                label: "Confirmar Contraseña",
                                controller: confirmPassword,
                                obscureText: textoObscuro2,
                                suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye), 
                                onPressed: (){
                                 
                                  setState(() {
                                     textoObscuro2 = !textoObscuro2;
                                  });
                                },),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          OutlinedButtomInicio(
                                ancho: screenP.ancho * 0.7,
                                texto: "Registrarse",
                                funcion: () {
                                  if (avatar.avatar.avatar.value.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Por favor, selecciona un avatar')),
                                    );
                                    return;
                                  }
                                  if(passwordController.text != confirmPassword.text){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("La contraseña no coinciden")),
                                    );
                                    return;
                                  }
                                  if (!formkey.currentState!.validate()) return;

                                  createUsers.createUserWithEmailAndPassword(
                                    nombre: nombreController.text,
                                    lastName: apellidoController.text,
                                    email: correoController.text,
                                    password: passwordController.text,
                                    image: avatar.avatar.avatar.value,
                                    userName: usuarioController.text,
                                  ).then((_){
                                    avatar.avatar.avatar.value = ''; 
                                  });
                                },
                                    color: Colors.white,
                                    textStyle: TextStyle(
                                      color: Color(0xFFFF5F6D),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    size: Size(screenP.ancho * 0.7, 50),
                                    elevation: 5,
                                  ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const closeIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
