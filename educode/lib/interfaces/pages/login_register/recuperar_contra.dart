import 'package:educode/controllers/user_controller.dart';
import 'package:educode/controllers/validaciones.dart';
import 'package:educode/interfaces/pages/login_register/widgets/icono_cerrar.dart';
import 'package:educode/interfaces/pages/login_register/widgets/screen_theme.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  // Controllers
  final TextEditingController email = TextEditingController();
  final Validacion validar = Validacion();
  final _formKey = GlobalKey<FormState>();
  final UserController getUser = UserController();

  @override
  Widget build(BuildContext context) {
    ScreenProperty screen = ScreenProperty(context: context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: closeIcon(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screen.altura * 0.18,
              width: screen.ancho,
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  "Recuperar la contraseña",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              width: screen.ancho,
              height: screen.altura * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("lib/assets/contra.png"),
                ),
              ),
            ),
            SizedBox(height: 35),
            Card(
              shadowColor: Colors.red,
              color: Colors.red[100],
              child: Row(
                children: [
                  Icon(Icons.warning),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      "Le enviaremos un correo al email que ingresó al registrarse. Procure que sea uno disponible a su disposición.",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35),
            Text("Ingrese su correo"),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Correo",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return validar.validacionCorreo(value);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Acción a realizar si la validación es exitosa
                  getUser.recuperarContrasena(email.text);
                }
              },
              child: Text("Enviar correo"),
            ),
          ],
        ),
      ),
    );
  }
}
