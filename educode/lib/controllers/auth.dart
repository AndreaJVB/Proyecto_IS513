import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/controllers/historial_controller.dart';
import 'package:educode/controllers/user_controller.dart';
import 'package:educode/models/usuarios.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _firebaseAuth.currentUser;
  final getUser = Get.put<UserController>(UserController());

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  // Referencia a la coleccion usuario
  final usuarioRef = FirebaseFirestore.instance.collection('usuarios');

  // Metodo de inicio de sesion con correo 
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_firebaseAuth.currentUser != null && _firebaseAuth.currentUser?.displayName != null) {
        getUser.user.value = currentUser;
        Get.offAllNamed('/home');
      } else {
        print("No se pudo iniciar sesión.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No se encontró un usuario con ese email.');
      } else if (e.code == 'wrong-password') {
        print('Contraseña incorrecta.');
      }
    }
  }

  // Metodo para crear usuarios
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String nombre,
    required String lastName,
    required String image,
    required String userName,
  }) async {
    try {
      // Mensaje de confirmacion
      bool? shouldSave = await Get.defaultDialog<bool>(
        title: "Confirmación",
        content: Text("¿Desea guardar el usuario?"),
        confirm: ElevatedButton(
          onPressed: () => Get.back(result: true),
          child: Text("Aceptar"),
        ),
        cancel: ElevatedButton(
          onPressed: () => Get.back(result: false),
          
          child: Text("Cancelar", style: TextStyle(color: Colors.red),),
        ),
      );

      
      if (shouldSave == true) {
        final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await userCredential.user!.updateProfile(
          displayName: "$nombre $lastName",
          photoURL: image,
        );

        final data = Usuarios(
          nombreUsuario: userName,
        );

        // Se crea el documento en firestore
        final userDocRef = usuarioRef.doc(userCredential.user!.uid);
        await userDocRef.set(data.toJson());

        // Si todo sale bien
        Get.defaultDialog(
          title: "Éxito",
          content: Text("Usuario agregado con éxito"),
          confirm: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("OK"),
          ),
        );

        // Send email verification if necessary
        // await sendEmailVerification();
      } else {
        print("Guardado cancelado por el usuario.");
      }
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      Get.snackbar('Error', 'Error al crear usuario: ${e.message}');
    }
  }

  // Metodo para cerrar la sesion
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Method for sending email verification
  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
      print("Correo de verificación enviado.");
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    }
  }

  // Metodo para ingresar con cuenta google
  Future<void> handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Se inicia con las credenciales
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        getUser.user.value = userCredential.user;
        HistorialController().CrearDocumento(currentUser: userCredential.user);
        Get.offAllNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.message}');
      Get.snackbar('Error', 'Google Sign-In falló: ${e.message}');
    } catch (e) {
      print('Error General: ${e.toString()}');
      Get.snackbar('Error', 'Ocurrió un error durante el Google Sign-In.');
    }
  }
}
