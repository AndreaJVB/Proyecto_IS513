import 'package:educode/controllers/user_controller.dart';
import 'package:educode/interfaces/pages/settings/widgets/account_text_custom.dart';
import 'package:educode/interfaces/pages/settings/widgets/text_password_custom.dart';
import 'package:educode/interfaces/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final UserController getUser = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    // Observables
    RxBool isEditName = false.obs;
    RxBool isEditEmail = false.obs;

    //CONTROLLER
    TextEditingController nombre = TextEditingController(text: getUser.user.value?.displayName ?? '');
    TextEditingController email = TextEditingController(text: getUser.user.value?.email ?? '');
    TextEditingController password = TextEditingController();
    TextEditingController newPassword = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF7B1FA2), Color(0xFF9C27B0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    CircleAvatarCustom(),
                    SizedBox(height: 20),
                    Obx((){
                      return Text(
                      getUser.user.value?.displayName ?? "User Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                    }),
                    SizedBox(height: 10),
                    Obx((){
                      return  Text(
                      getUser.user.value?.email ?? "user@example.com",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    );
                    }),
                    
                    SizedBox(height: 20),
                    Divider(color: Colors.white54),
                    
                    TextFieldAccount(nombre: nombre, isEdit: isEditName, label: "Nombre"),
                    SizedBox(height: 10),
                    TextFieldAccount(nombre: email, isEdit: isEditEmail, label: "Correo"),
                    SizedBox(height: 10),
                    
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actionsPadding: EdgeInsets.all(10),
                              title: Text("CAMBIO DE CONTRASEÑA"),
                              content: Container(
                                height: 200,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextPassword(password: password, label: "Contraseña actual"),
                                      SizedBox(height: 20),
                                      TextPassword(password: newPassword, label: "Nueva contraseña"),
                                      SizedBox(height: 20),
                                      OutlinedButton(
                                        onPressed: () {
                                          getUser.cambiarContrasena(password.text, newPassword.text);
                                          Navigator.of(context).pop(); // Cerrar el diálogo
                                        },
                                        child: Text("Guardar contraseña"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text("Cambiar contraseña", style: TextStyle(color: Colors.white)),
                    ),
                    
                    SizedBox(height: 10),
                    Obx(() => (isEditName.value || isEditEmail.value)
                        ? ElevatedButton(
                            onPressed: () {
                              getUser.actualizarDatos(email.text, nombre.text).then((_) {
                                // Después de actualizar los datos, restablecer el modo de edición
                                isEditName.value = false;
                                isEditEmail.value = false;
                              });
                            },
                            child: Text("Guardar cambios"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                        : SizedBox.shrink()),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Icon(Icons.settings, color: Colors.deepPurple),
                  title: Text('Cambiar modo de juego'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                  onTap: () {
                    // Navigate to settings
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.redAccent),
                  title: Text('Cerrar sesión'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
                  onTap: () {
                    getUser.cerrarSesion();
                    
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}