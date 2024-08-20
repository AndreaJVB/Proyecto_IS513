import 'package:educode/controllers/user_controller.dart';
import 'package:educode/controllers/historial_controller.dart'; // Asegúrate de importar el HistorialController
import 'package:educode/interfaces/pages/settings/widgets/account_text_custom.dart';
import 'package:educode/interfaces/pages/settings/widgets/text_password_custom.dart';
import 'package:educode/interfaces/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final UserController getUser = Get.find<UserController>();
  final HistorialController historialController = HistorialController(); // Instancia de HistorialController

  @override
  Widget build(BuildContext context) {
    // Observables
    RxBool isEditName = false.obs;
    RxBool isEditUsuario = false.obs;

    // Controllers
    TextEditingController nombre = TextEditingController();
    TextEditingController usuario = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController newPassword = TextEditingController();

    // Initialize controllers with current user values
    Future<void> initializeControllers() async {
      final currentUser = getUser.user.value;
      nombre.text = currentUser?.displayName ?? '';
      
      // Get the username using HistorialController
      final username = await historialController.getNombreUsuario(currentUser);
      usuario.text = username;

      CircleAvatarCustom().avatar.avatar.value = currentUser?.photoURL ?? '';
    }

    // Call this function when building
    initializeControllers();

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
                    Obx(() {
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
                    Obx(() {
                      return Text(
                        getUser.user.value?.email ?? "user@example.com",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      );
                    }),
                    SizedBox(height: 20),
                    Divider(color: Colors.white54),
                    TextFieldAccount(
                      nombre: nombre,
                      isEdit: isEditName,
                      label: "Nombre",
                    ),
                    SizedBox(height: 10),
                    TextFieldAccount(
                      nombre: usuario,
                      isEdit: isEditUsuario,
                      label: "Usuario",
                    ),
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
                                      TextPassword(
                                        password: password,
                                        label: "Contraseña actual",
                                      ),
                                      SizedBox(height: 20),
                                      TextPassword(
                                        password: newPassword,
                                        label: "Nueva contraseña",
                                      ),
                                      SizedBox(height: 20),
                                      OutlinedButton(
                                        onPressed: () {
                                          getUser.cambiarContrasena(
                                            password.text,
                                            newPassword.text,
                                          );
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
                    Obx(() => (isEditName.value || isEditUsuario.value || CircleAvatarCustom().avatar.avatar.value != getUser.user.value?.photoURL)
                        ? ElevatedButton(
                            onPressed: () {
                              historialController.actualizarNombreUsuario(
                                uid: getUser.user.value!.uid, nuevoNombreUsuario: usuario.text);
                              getUser.actualizarDatos(
                                nombre.text,
                                CircleAvatarCustom().avatar.avatar.value,
                              ).then((_) {
                                // Después de actualizar los datos, restablecer el modo de edición
                                isEditName.value = false;
                                isEditUsuario.value = false;
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
                    Get.offAllNamed('/home');
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
