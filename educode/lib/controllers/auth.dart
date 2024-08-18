
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/controllers/historial_controller.dart';
import 'package:educode/controllers/user_controller.dart';
import 'package:educode/models/usuarios.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _firebaseAuth.currentUser;
  final getUser = Get.put<UserController>(UserController());

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  //Referencia a la base de datos
  final usuarioRef = FirebaseFirestore.instance.collection('usuarios');

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
        try {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, 
            password: password
          );
          if(_firebaseAuth.currentUser != null && _firebaseAuth.currentUser?.displayName != null){
            getUser.user.value = currentUser;
            Get.offAllNamed('/home');
          }else{
            print("NO PODRA ENTRARA");
          }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String nombre,
    required String lastName,
    required String image,
    required String userName,
  })  async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );

      await userCredential.user!.updateProfile(
        displayName: "$nombre $lastName",
        photoURL: image,
      );

      final data = Usuarios(
        nombreUsuario: userName
      );
       // Crear el documento del usuario
      final userDocRef = usuarioRef.doc(userCredential.user!.uid);
      await userDocRef.set(data.toJson());

      // Crear la subcolección 'historial'
      final historialRef = userDocRef.collection('historial');
      // Puedes agregar documentos en la subcolección 'historial' aquí si es necesario
      await historialRef.add({
        'created_at': FieldValue.serverTimestamp(),
        'action': 'User created',
      });
      
       // Enviar correo de verificación después de crear el usuario
      // await sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
      print("Correo de verificación enviado.");
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    }
  }

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
      
      // Se inicia sesion con las credenciales
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        getUser.user.value = userCredential.user;
        HistorialController().CrearDocumento(currentUser: userCredential.user);
        Get.offAllNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.message}');
      Get.snackbar('Error', 'Google Sign-In failed: ${e.message}');
    } catch (e) {
      print('General Error: ${e.toString()}');
      Get.snackbar('Error', 'An error occurred during Google Sign-In.');
    }
  }

}
