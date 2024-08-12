import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);
  final RxInt selectedIndex = 0.obs;
  final RxInt selectedIndexMulti = 0.obs;
  

  @override
  void onInit() {
    super.onInit();

    // Escuchar cambios en la autenticación
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      user.value = newUser;
    });
  }

  //CERRAR SESION
  Future<void> cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/'); // Navega a la pantalla de inicio o login
  }

  //CAMBIAR CONTRA DNTRO DE LA SESION
  Future<void> cambiarContrasena(String contrasenaActual, String nuevaContrasena) async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Reautenticar al usuario con la contraseña actual
        final AuthCredential credential = EmailAuthProvider.credential(
          email: currentUser.email!,
          password: contrasenaActual,
        );

        await currentUser.reauthenticateWithCredential(credential);

        // Cambiar la contraseña
        await currentUser.updatePassword(nuevaContrasena);
        await FirebaseAuth.instance.currentUser?.reload(); // Recargar el usuario para obtener la información actualizada
        user.value = FirebaseAuth.instance.currentUser; // Actualizar el observable
        Get.snackbar('Éxito', 'Contraseña cambiada con éxito', backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'No hay usuario autenticado');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cambiar la contraseña: $e', backgroundColor: Colors.red[200]);
    }
  }

  //ACTUALIZAR EMAIL Y NOMBRE
  Future<void> actualizarDatos(String email, String nombre) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Actualizar el nombre
        await currentUser.updateProfile(displayName: nombre);
        
        // Verificar el correo antes de actualizarlo
        await currentUser.verifyBeforeUpdateEmail(email, );
        
        // Recargar el usuario para obtener la información actualizada
        await currentUser.reload();
        user.value = FirebaseAuth.instance.currentUser;
        
        Get.snackbar('Éxito', 'Datos actualizados con éxito', backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'No hay usuario autenticado');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar los datos: $e', backgroundColor: Colors.red[200]);
    }
  }

  //CORREO DE RECUPERACION DE CONTRASEÑA
  Future<void> recuperarContrasena(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar('Éxito', 'Correo de recuperación enviado a $email', backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'No se pudo enviar el correo de recuperación: $e', backgroundColor: Colors.red[200]);
    }
  }
}
