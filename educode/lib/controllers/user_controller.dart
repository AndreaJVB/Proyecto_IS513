import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController extends GetxController {
  final Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final RxInt selectedIndex = 0.obs;
  final RxInt selectedIndexMulti = 0.obs;
  
  @override
  void onInit() {
    super.onInit();

    // Escuchar cambios en la autenticación
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      user.value = newUser;
      if (newUser != null) {
        // Actualizar datos del usuario si es necesario
        updateUserData();
      }
    });
  }

  Future<void> updateUserData() async {
    if (user.value != null) {
      try {
        // Recargar el usuario para obtener la información actualizada
        await user.value!.reload();
        user.value = FirebaseAuth.instance.currentUser;
      } catch (e) {
        print('Error al actualizar los datos del usuario: $e');
      }
    }
  }

  Future<void> cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    Get.offAllNamed('/'); // Navega a la pantalla de inicio o login
  }

  Future<void> cambiarContrasena(String contrasenaActual, String nuevaContrasena) async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final AuthCredential credential = EmailAuthProvider.credential(
          email: currentUser.email!,
          password: contrasenaActual,
        );

        await currentUser.reauthenticateWithCredential(credential);
        await currentUser.updatePassword(nuevaContrasena);
        await updateUserData(); // Actualizar datos del usuario
        Get.snackbar('Éxito', 'Contraseña cambiada con éxito', backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'No hay usuario autenticado');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cambiar la contraseña: $e', backgroundColor: Colors.red[200]);
    }
  }

  Future<void> actualizarDatos(String nombre, String image) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await currentUser.updateProfile(displayName: nombre);
        await currentUser.updatePhotoURL(image);
        await updateUserData(); // Actualizar datos del usuario
        
        Get.snackbar('Éxito', 'Datos actualizados con éxito', backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'No hay usuario autenticado');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo actualizar los datos: $e', backgroundColor: Colors.red[200]);
    }
  }

  Future<void> recuperarContrasena(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar('Éxito', 'Correo de recuperación enviado a $email', backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'No se pudo enviar el correo de recuperación: $e', backgroundColor: Colors.red[200]);
    }
  }
}
